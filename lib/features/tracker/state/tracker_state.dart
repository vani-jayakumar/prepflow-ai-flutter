import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../model/interview_log_model.dart';

part 'tracker_state.freezed.dart';

@freezed
class TrackerState with _$TrackerState {
  const factory TrackerState({
    @Default([]) List<InterviewLogModel> upcomingLogs,
    @Default([]) List<InterviewLogModel> historyLogs,
    @Default(LoaderState.initial) LoaderState loaderState,
    String? errorMessage,
  }) = _TrackerState;
}
