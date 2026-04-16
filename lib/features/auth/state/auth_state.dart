import 'package:freezed_annotation/freezed_annotation.dart';
import '../model/auth_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    AuthModel? user,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _AuthState;
}
