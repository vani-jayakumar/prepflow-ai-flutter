import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../model/session_model.dart';

part 'session_state.freezed.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    SessionModel? currentSession,
    @Default([]) List<MessageModel> messages,
    @Default(LoaderState.initial) LoaderState loaderState,
    @Default(false) bool isTyping,
    String? errorMessage,
  }) = _SessionState;
}
