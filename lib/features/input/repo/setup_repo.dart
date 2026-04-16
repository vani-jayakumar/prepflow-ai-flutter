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
  })  : _firestoreService = firestoreService,
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
      final cleanedJson = jsonResponse.replaceAll('```json', '').replaceAll('```', '').trim();
      final data = jsonDecode(cleanedJson);
      final model = AnalysisModel.fromJson(data);
      
      return right(model);
    } catch (e) {
      return left('AI Analysis failed: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> saveAnalysis(String uid, AnalysisModel analysis) async {
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
}
