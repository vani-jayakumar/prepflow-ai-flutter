import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../../../core/services/ai_service.dart';
import '../../auth/notifier/auth_notifier.dart';
import '../model/session_model.dart';
import '../repo/session_repo.dart';
import '../state/session_state.dart';

part 'session_notifier.g.dart';

@riverpod
class SessionNotifier extends _$SessionNotifier {
  @override
  SessionState build() => const SessionState();

  Future<void> startNewSession(String roleContext) async {
    final authState = ref.read(authNotifierProvider);
    final user = authState.user;
    if (user == null) return;

    state = state.copyWith(loaderState: LoaderState.loading, errorMessage: null);

    final repo = ref.read(sessionRepositoryProvider);
    final ai = ref.read(aiServiceProvider);

    final initialSession = SessionModel(
      userId: user.uid,
      roleContext: roleContext,
      messages: [],
      startedAt: DateTime.now(),
    );

    final result = await repo.createSession(initialSession);

    await result.fold(
      (error) async => state = state.copyWith(loaderState: LoaderState.error, errorMessage: error),
      (sessionId) async {
        final session = initialSession.copyWith(id: sessionId);
        state = state.copyWith(
          currentSession: session,
          loaderState: LoaderState.loaded,
          isTyping: true,
        );

        // Get initial question from AI
        final welcomeMsg = await ai.getInterviewResponse(
          chatHistory: [],
          jobContext: roleContext,
        );

        final firstMessage = MessageModel(
          text: welcomeMsg,
          role: 'assistant',
          timestamp: DateTime.now(),
        );

        final updatedMessages = [firstMessage];
        await repo.updateSession(sessionId, {
          'messages': updatedMessages.map((m) => m.toJson()).toList(),
        });

        state = state.copyWith(
          messages: updatedMessages,
          isTyping: false,
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
    state = state.copyWith(messages: updatedMessages, isTyping: true);

    final repo = ref.read(sessionRepositoryProvider);
    final ai = ref.read(aiServiceProvider);

    // Sync to Firestore
    await repo.updateSession(session.id!, {
      'messages': updatedMessages.map((m) => m.toJson()).toList(),
    });

    // Get AI Response
    final aiResponseText = await ai.getInterviewResponse(
      chatHistory: updatedMessages.map((m) => {'role': m.role, 'text': m.text}).toList(),
      jobContext: session.roleContext,
    );

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
}
