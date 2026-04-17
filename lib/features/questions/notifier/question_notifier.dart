import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../../input/model/analysis_model.dart';
import '../../settings/notifier/profile_notifier.dart';
import '../../settings/state/profile_state.dart';
import '../model/question_model.dart';
import '../repo/question_repo.dart';
import '../state/question_state.dart';

part 'question_notifier.g.dart';

@riverpod
class QuestionNotifier extends _$QuestionNotifier {
  @override
  QuestionState build() {
    Future.microtask(_init);
    return const QuestionState();
  }

  Future<void> _init() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    _syncFromProfile(ref.read(profileNotifierProvider));

    // Watch profile for personalized questions from AI analysis.
    // This keeps Question Bank updated whenever a new analysis is saved.
    ref.listen(profileNotifierProvider, (prev, next) {
      _syncFromProfile(next);
    });

    final repo = ref.read(questionRepositoryProvider);
    final result = await repo.getUniversalQuestions();

    result.fold(
      (error) => state = state.copyWith(
        loaderState: state.personalizedQuestions.isNotEmpty
            ? LoaderState.loaded
            : LoaderState.error,
        errorMessage: error,
      ),
      (list) => state = state.copyWith(
        universalQuestions: list,
        loaderState: LoaderState.loaded,
        errorMessage: null,
      ),
    );
  }

  void _syncFromProfile(ProfileState profileState) {
    final rawAnalysis = profileState.user?.lastAnalysis;
    if (rawAnalysis == null) {
      state = state.copyWith(personalizedQuestions: []);
      return;
    }

    try {
      final analysis = AnalysisModel.fromJson(rawAnalysis);
      final personalized = analysis.interviewQuestions
          .map((q) => q.trim())
          .where((q) => q.isNotEmpty)
          .toSet()
          .map(
            (q) => QuestionModel(
              text: q,
              isPersonalized: true,
              tags: [
                'AI Generated',
                _isBehavioralQuestion(q) ? 'Behavioral' : 'Technical',
              ],
            ),
          )
          .toList();

      state = state.copyWith(personalizedQuestions: personalized);
    } catch (_) {
      state = state.copyWith(personalizedQuestions: []);
    }
  }

  bool _isBehavioralQuestion(String question) {
    final normalized = question.toLowerCase();
    const behavioralHints = [
      'tell me about',
      'how do you handle',
      'how did you',
      'conflict',
      'lead',
      'team',
      'stakeholder',
      'deadline',
      'communication',
      'challenge',
      'mistake',
      'feedback',
    ];
    return behavioralHints.any(normalized.contains);
  }
}
