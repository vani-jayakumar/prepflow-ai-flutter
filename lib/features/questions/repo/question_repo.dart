import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/firestore_service.dart';
import '../model/question_model.dart';

part 'question_repo.g.dart';

@riverpod
class QuestionRepository extends _$QuestionRepository {
  @override
  QuestionRepo build() {
    return QuestionRepo(
      firestoreService: ref.watch(firestoreServiceProvider),
    );
  }
}

abstract class IQuestionRepo {
  Future<Either<String, List<QuestionModel>>> getUniversalQuestions();
  Future<Either<String, void>> savePersonalizedQuestion(String uid, QuestionModel question);
}

class QuestionRepo implements IQuestionRepo {
  final FirestoreService _firestoreService;

  QuestionRepo({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Future<Either<String, List<QuestionModel>>> getUniversalQuestions() async {
    try {
      final snapshot = await _firestoreService.db.collection('questions').get();
      final list = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return QuestionModel.fromJson(data);
      }).toList();
      return right(list);
    } catch (e) {
      return left('Failed to fetch questions: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> savePersonalizedQuestion(String uid, QuestionModel question) async {
    try {
      await _firestoreService.db
          .collection('users')
          .doc(uid)
          .collection('saved_questions')
          .add(question.toJson());
      return right(null);
    } catch (e) {
      return left('Failed to save question: ${e.toString()}');
    }
  }
}
