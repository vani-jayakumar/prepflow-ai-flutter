import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/ai_service.dart';
import '../model/analysis_model.dart';

part 'setup_repo.g.dart';

@riverpod
class SetupRepository extends _$SetupRepository {
  @override
  SetupRepo build() {
    return SetupRepo(
      firestoreService: ref.watch(firestoreServiceProvider),
      aiService: ref.watch(aiServiceProvider),
    );
  }
}

abstract class ISetupRepo {
  Future<Either<String, AnalysisModel>> generateAnalysis({
    required String resumeContent,
    required String jobDescription,
    required String companyContext,
  });
  Future<Either<String, void>> saveAnalysis(String uid, AnalysisModel analysis);
}

class SetupRepo implements ISetupRepo {
  final FirestoreService _firestoreService;
  final AIService _aiService;

  SetupRepo({
    required FirestoreService firestoreService,
    required AIService aiService,
  }) : _firestoreService = firestoreService,
       _aiService = aiService;

  @override
  Future<Either<String, AnalysisModel>> generateAnalysis({
    required String resumeContent,
    required String jobDescription,
    required String companyContext,
  }) async {
    try {
      final jsonResponse = await _aiService.analyzeResume(
        resumeContent: resumeContent,
        jobDescription: jobDescription,
        companyContext: companyContext,
      );

      // Basic cleaning in case AI includes markdown wrappers
      final cleanedJson = jsonResponse
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();
      final data = jsonDecode(cleanedJson);
      final model = AnalysisModel.fromJson(data);
      final normalizedModel = _ensureInterviewQuestions(
        model,
        jobDescription: jobDescription,
        companyContext: companyContext,
      );

      return right(normalizedModel);
    } catch (e) {
      return left('AI Analysis failed: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> saveAnalysis(
    String uid,
    AnalysisModel analysis,
  ) async {
    try {
      await _firestoreService.updateUser(uid, {
        'lastAnalysis': analysis.toJson(),
        'readinessScore': analysis.readinessScore,
      });
      return right(null);
    } catch (e) {
      return left('Failed to save analysis: ${e.toString()}');
    }
  }

  AnalysisModel _ensureInterviewQuestions(
    AnalysisModel model, {
    required String jobDescription,
    required String companyContext,
  }) {
    final cleanedQuestions = model.interviewQuestions
        .map((q) => q.trim())
        .where((q) => q.isNotEmpty)
        .toSet()
        .toList();

    if (cleanedQuestions.isNotEmpty) {
      return model.copyWith(interviewQuestions: cleanedQuestions);
    }

    final role = _extractRole(companyContext);
    final prioritizedTopics =
        <String>[
              ...model.skillGaps,
              ...model.focusAreas.where((f) => !model.skillGaps.contains(f)),
            ]
            .map((topic) => topic.trim())
            .where((topic) => topic.isNotEmpty)
            .toSet()
            .take(4)
            .toList();

    final fallbackQuestions = <String>[
      'Walk me through your experience most relevant to $role.',
      'How would you approach designing a scalable solution for $role?',
      for (final topic in prioritizedTopics)
        'How would you handle $topic in a real project setting?',
      'Tell me about a challenging project and how you handled trade-offs.',
      'How do you prioritize tasks when deadlines are tight?',
      if (jobDescription.trim().isNotEmpty)
        'Which requirement from this job description would you tackle first, and why?',
    ].map((q) => q.trim()).where((q) => q.isNotEmpty).toSet().take(8).toList();

    return model.copyWith(interviewQuestions: fallbackQuestions);
  }

  String _extractRole(String companyContext) {
    final normalized = companyContext.trim();
    if (normalized.isEmpty) return 'this role';

    final splitByAt = normalized.split(' at ');
    final role = splitByAt.first.trim();
    if (role.isNotEmpty) return role;

    return 'this role';
  }
}
