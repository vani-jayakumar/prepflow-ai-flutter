import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../model/question_model.dart';

part 'question_state.freezed.dart';

@freezed
class QuestionState with _$QuestionState {
  const factory QuestionState({
    @Default([]) List<QuestionModel> universalQuestions,
    @Default([]) List<QuestionModel> personalizedQuestions,
    @Default(LoaderState.initial) LoaderState loaderState,
    String? errorMessage,
  }) = _QuestionState;
}
