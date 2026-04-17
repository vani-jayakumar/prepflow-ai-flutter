import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/firestore_service.dart';
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
    state = state.copyWith(
      useMasterResume: use,
      selectedResume: use ? null : state.selectedResume,
    );
  }

  Future<void> runAnalysis() async {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) {
      state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: 'User not authenticated',
      );
      return;
    }

    state = state.copyWith(
      loaderState: LoaderState.loading,
      errorMessage: null,
    );

    final hasJobDescription = state.jobDescription.trim().isNotEmpty;
    final hasTargetRole = state.targetRole.trim().isNotEmpty;
    if (!hasJobDescription && !hasTargetRole) {
      state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage:
            'Please add a job description or target role to generate questions.',
      );
      return;
    }

    var profileUser = ref.read(profileNotifierProvider).user;
    if (profileUser == null) {
      profileUser = await ref
          .read(firestoreServiceProvider)
          .getUser(authUser.uid);
    }

    final repo = ref.read(setupRepositoryProvider);

    // Determine which resume to use
    String resumeContent = '';
    // FOR DEMO/MVP: We'll assume the AI service takes the URL or we extract text.
    // Ideally, we'd pass the file bytes to Gemini.
    if (state.useMasterResume) {
      if (profileUser?.masterResumeUrl == null) {
        state = state.copyWith(
          loaderState: LoaderState.error,
          errorMessage: 'Master resume not found or profile still loading',
        );
        return;
      }
      resumeContent = 'Using Master Resume: ${profileUser!.masterResumeUrl}';
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
      companyContext: _buildCompanyContext(
        role: state.targetRole,
        company: state.companyName,
      ),
    );

    await result.fold(
      (error) async {
        state = state.copyWith(
          loaderState: LoaderState.error,
          errorMessage: error,
        );
      },
      (analysis) async {
        // Save to Firestore
        final saveResult = await repo.saveAnalysis(authUser.uid, analysis);
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

  String _buildCompanyContext({required String role, required String company}) {
    final roleTrimmed = role.trim();
    final companyTrimmed = company.trim();

    if (roleTrimmed.isNotEmpty && companyTrimmed.isNotEmpty) {
      return '$roleTrimmed at $companyTrimmed';
    }
    if (roleTrimmed.isNotEmpty) return roleTrimmed;
    if (companyTrimmed.isNotEmpty) return companyTrimmed;
    return 'Target role context';
  }
}
