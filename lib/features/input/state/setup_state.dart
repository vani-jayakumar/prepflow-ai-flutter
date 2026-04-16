import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../model/analysis_model.dart';

part 'setup_state.freezed.dart';

@freezed
class SetupState with _$SetupState {
  const factory SetupState({
    @Default('') String jobDescription,
    @Default('') String companyName,
    @Default('') String targetRole,
    File? selectedResume,
    @Default(false) bool useMasterResume,
    AnalysisModel? analysisResult,
    @Default(LoaderState.initial) LoaderState loaderState,
    String? errorMessage,
  }) = _SetupState;
}
