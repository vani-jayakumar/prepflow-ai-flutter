import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../../../core/services/ai_service.dart';
import '../../auth/notifier/auth_notifier.dart';
import '../../input/model/analysis_model.dart';
import '../../input/notifier/setup_notifier.dart';
import '../../settings/notifier/profile_notifier.dart';
import '../model/session_model.dart';
import '../repo/session_repo.dart';
import '../state/session_state.dart';

part 'session_notifier.g.dart';

@riverpod
class SessionNotifier extends _$SessionNotifier {
  @override
  SessionState build() => const SessionState();

  Future<void> initializeSession({String? selectedQuestion}) async {
    if (state.loaderState == LoaderState.loading) return;
    final hasExistingSession =
        state.currentSession != null && state.messages.isNotEmpty;

    final selectedQuestionTrimmed = selectedQuestion?.trim();
    final shouldForceRestart =
        selectedQuestionTrimmed != null && selectedQuestionTrimmed.isNotEmpty;

    if (hasExistingSession && !shouldForceRestart) return;

    final setupState = ref.read(setupNotifierProvider);
    final profileState = ref.read(profileNotifierProvider);

    final roleContext = _buildRoleContext(
      role: setupState.targetRole,
      company: setupState.companyName,
      analysis: _extractAnalysis(profileState.user?.lastAnalysis),
    );
    final seedQuestion = shouldForceRestart
        ? selectedQuestionTrimmed
        : _extractSeedQuestion(profileState.user?.lastAnalysis);

    if (hasExistingSession && shouldForceRestart) {
      state = const SessionState();
    }

    await startNewSession(roleContext, seedQuestion: seedQuestion);
  }

  Future<void> startNewSession(
    String roleContext, {
    String? seedQuestion,
  }) async {
    final authState = ref.read(authNotifierProvider);
    final userId =
        authState.user?.uid ?? FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: 'Please sign in to start a mock interview.',
      );
      return;
    }

    state = state.copyWith(
      loaderState: LoaderState.loading,
      errorMessage: null,
    );

    final repo = ref.read(sessionRepositoryProvider);
    final ai = ref.read(aiServiceProvider);

    final initialSession = SessionModel(
      userId: userId,
      roleContext: roleContext,
      messages: [],
      startedAt: DateTime.now(),
    );

    final result = await repo.createSession(initialSession);

    await result.fold(
      (error) async => state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: error,
      ),
      (sessionId) async {
        final session = initialSession.copyWith(id: sessionId);
        state = state.copyWith(
          currentSession: session,
          loaderState: LoaderState.loaded,
          isTyping: true,
        );

        String firstPrompt = '';
        final selectedQuestion = seedQuestion?.trim();

        // If a specific bank question was selected, it must be the first prompt.
        if (selectedQuestion != null && selectedQuestion.isNotEmpty) {
          firstPrompt = selectedQuestion;
        } else {
          // Otherwise, get initial question from AI with safe fallback.
          try {
            firstPrompt = await ai.getInterviewResponse(
              chatHistory: [],
              jobContext: roleContext,
            );
          } catch (_) {}

          if (firstPrompt.trim().isEmpty) {
            firstPrompt = _fallbackOpeningQuestion(roleContext, seedQuestion);
          }
        }

        final firstMessage = MessageModel(
          text: firstPrompt,
          role: 'assistant',
          timestamp: DateTime.now(),
        );

        final updatedMessages = [firstMessage];
        final syncResult = await repo.updateSession(sessionId, {
          'messages': updatedMessages.map((m) => m.toJson()).toList(),
        });
        syncResult.fold((_) {}, (_) {});

        state = state.copyWith(
          messages: updatedMessages,
          isTyping: false,
          loaderState: LoaderState.loaded,
        );
      },
    );
  }

  Future<void> sendMessage(String text) async {
    final session = state.currentSession;
    if (session == null || state.isTyping) return;

    final userMessage = MessageModel(
      text: text,
      role: 'user',
      timestamp: DateTime.now(),
    );

    final updatedMessages = [...state.messages, userMessage];
    state = state.copyWith(
      messages: updatedMessages,
      isTyping: true,
      errorMessage: null,
    );

    final repo = ref.read(sessionRepositoryProvider);
    final ai = ref.read(aiServiceProvider);

    // Sync to Firestore
    await repo.updateSession(session.id!, {
      'messages': updatedMessages.map((m) => m.toJson()).toList(),
    });

    // Get AI Response
    String aiResponseText = '';
    try {
      aiResponseText = await ai.getInterviewResponse(
        chatHistory: updatedMessages
            .map((m) => {'role': m.role, 'text': m.text})
            .toList(),
        jobContext: session.roleContext,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'AI response failed. Showing fallback prompt.',
      );
    }

    if (aiResponseText.trim().isEmpty) {
      aiResponseText = _fallbackFollowUpQuestion(session.roleContext, text);
    }

    final aiMessage = MessageModel(
      text: aiResponseText,
      role: 'assistant',
      timestamp: DateTime.now(),
    );

    final finalMessages = [...updatedMessages, aiMessage];

    // Final sync
    await repo.updateSession(session.id!, {
      'messages': finalMessages.map((m) => m.toJson()).toList(),
    });

    state = state.copyWith(messages: finalMessages, isTyping: false);
  }

  Future<void> restartSession() async {
    state = const SessionState();
    await initializeSession();
  }

  AnalysisModel? _extractAnalysis(Map<String, dynamic>? rawAnalysis) {
    if (rawAnalysis == null) return null;
    try {
      return AnalysisModel.fromJson(rawAnalysis);
    } catch (_) {
      return null;
    }
  }

  String? _extractSeedQuestion(Map<String, dynamic>? rawAnalysis) {
    final analysis = _extractAnalysis(rawAnalysis);
    if (analysis == null || analysis.interviewQuestions.isEmpty) return null;
    return analysis.interviewQuestions.firstWhere(
      (q) => q.trim().isNotEmpty,
      orElse: () => '',
    );
  }

  String _buildRoleContext({
    required String role,
    required String company,
    required AnalysisModel? analysis,
  }) {
    final roleTrimmed = role.trim();
    final companyTrimmed = company.trim();

    if (roleTrimmed.isNotEmpty && companyTrimmed.isNotEmpty) {
      return '$roleTrimmed at $companyTrimmed';
    }
    if (roleTrimmed.isNotEmpty) return roleTrimmed;
    if (companyTrimmed.isNotEmpty) return 'Interview at $companyTrimmed';

    final focus = analysis?.focusAreas
        .map((f) => f.trim())
        .where((f) => f.isNotEmpty)
        .toList();
    if (focus != null && focus.isNotEmpty) {
      return 'Software Engineer Interview (${focus.take(2).join(', ')})';
    }

    return 'Software Engineer Interview';
  }

  String _fallbackOpeningQuestion(String roleContext, String? seedQuestion) {
    if (seedQuestion != null && seedQuestion.trim().isNotEmpty) {
      return 'Welcome to your $roleContext mock interview.\n\n$seedQuestion';
    }
    return 'Welcome to your $roleContext mock interview. '
        'Tell me about yourself and the most relevant project you have worked on.';
  }

  String _fallbackFollowUpQuestion(String roleContext, String userAnswer) {
    if (userAnswer.trim().length < 30) {
      return 'Thanks. Could you expand your answer with a concrete example relevant to $roleContext?';
    }
    return 'Good response. What trade-offs did you consider, and what would you improve if you were doing it again?';
  }
}
