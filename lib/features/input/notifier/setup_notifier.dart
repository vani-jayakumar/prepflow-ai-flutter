import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../../settings/notifier/profile_notifier.dart';
import '../repo/setup_repo.dart';
import '../state/setup_state.dart';

part 'setup_notifier.g.dart';

@riverpod
class SetupNotifier extends _$SetupNotifier {
  @override
  SetupState build() => const SetupState();

  void updateJobDescription(String jd) {
    state = state.copyWith(jobDescription: jd);
  }

  void updateCompanyDetails({String? name, String? role}) {
    state = state.copyWith(
      companyName: name ?? state.companyName,
      targetRole: role ?? state.targetRole,
    );
  }

  void selectResumeFile(File file) {
    state = state.copyWith(selectedResume: file, useMasterResume: false);
  }

  void toggleUseMasterResume(bool use) {
    state = state.copyWith(useMasterResume: use, selectedResume: use ? null : state.selectedResume);
  }

  Future<void> runAnalysis() async {
    final user = ref.read(profileNotifierProvider).user;
    if (user == null) {
      state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: 'User profile not loaded',
      );
      return;
    }

    state = state.copyWith(loaderState: LoaderState.loading, errorMessage: null);

    final repo = ref.read(setupRepositoryProvider);
    
    // Determine which resume to use
    String resumeContent = '';
    // FOR DEMO/MVP: We'll assume the AI service takes the URL or we extract text.
    // Ideally, we'd pass the file bytes to Gemini.
    if (state.useMasterResume) {
      resumeContent = 'Using Master Resume: ${user.masterResumeUrl}';
    } else if (state.selectedResume != null) {
      resumeContent = 'Manual Upload: ${state.selectedResume!.path}';
    } else {
       state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: 'No resume selected',
      );
      return;
    }

    final result = await repo.generateAnalysis(
      resumeContent: resumeContent,
      jobDescription: state.jobDescription,
      companyContext: '${state.targetRole} at ${state.companyName}',
    );

    await result.fold(
      (error) async {
        state = state.copyWith(loaderState: LoaderState.error, errorMessage: error);
      },
      (analysis) async {
        // Save to Firestore
        final saveResult = await repo.saveAnalysis(user.uid, analysis);
        saveResult.fold(
          (saveError) => state = state.copyWith(
            loaderState: LoaderState.error, 
            errorMessage: saveError,
            analysisResult: analysis, // Still hold result
          ),
          (_) => state = state.copyWith(
            loaderState: LoaderState.loaded,
            analysisResult: analysis,
          ),
        );
      },
    );
  }
}
