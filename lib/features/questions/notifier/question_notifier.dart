import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../../input/model/analysis_model.dart';
import '../../settings/notifier/profile_notifier.dart';
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

    final repo = ref.read(questionRepositoryProvider);
    final result = await repo.getUniversalQuestions();

    // Watch profile for personalized questions from AI analysis
    ref.listen(profileNotifierProvider, (prev, next) {
      if (next.user?.lastAnalysis != null) {
        try {
          final analysis = AnalysisModel.fromJson(next.user!.lastAnalysis!);
          final personalized = analysis.interviewQuestions.map((q) => QuestionModel(
            text: q,
            isPersonalized: true,
            tags: ['AI Generated'],
          )).toList();
          
          state = state.copyWith(personalizedQuestions: personalized);
        } catch (_) {}
      }
    });

    result.fold(
      (error) => state = state.copyWith(loaderState: LoaderState.error, errorMessage: error),
      (list) => state = state.copyWith(
        universalQuestions: list,
        loaderState: LoaderState.loaded,
      ),
    );
  }
}
