import 'package:freezed_annotation/freezed_annotation.dart';
import '../../auth/model/user_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    UserModel? user,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isUploadingResume,
    @Default(false) bool isUploadingAvatar,
  }) = _ProfileState;
}
