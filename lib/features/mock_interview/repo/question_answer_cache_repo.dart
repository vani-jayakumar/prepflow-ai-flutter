import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/firestore_service.dart';

final questionAnswerCacheRepoProvider = Provider(
  (ref) => QuestionAnswerCacheRepo(
    firestoreService: ref.read(firestoreServiceProvider),
  ),
);

class QuestionAnswerCache {
  final String answer;
  final String source;
  final DateTime? updatedAt;

  const QuestionAnswerCache({
    required this.answer,
    required this.source,
    this.updatedAt,
  });
}

class QuestionAnswerCacheRepo {
  final FirestoreService _firestoreService;

  QuestionAnswerCacheRepo({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  String normalizeQuestion(String question) {
    return question.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  Future<QuestionAnswerCache?> getCachedAnswer({
    required String uid,
    required String question,
  }) async {
    final normalized = normalizeQuestion(question);
    final query = await _firestoreService.db
        .collection('users')
        .doc(uid)
        .collection('question_answers')
        .where('normalizedQuestion', isEqualTo: normalized)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    final data = query.docs.first.data();
    final answer = (data['answer'] as String?)?.trim() ?? '';
    if (answer.isEmpty) return null;

    DateTime? updatedAt;
    try {
      updatedAt = (data['updatedAt'] as Timestamp?)?.toDate();
    } catch (_) {
      // Ignore timestamp conversion errors
    }

    return QuestionAnswerCache(
      answer: answer,
      source: (data['source'] as String?)?.trim() ?? 'unknown',
      updatedAt: updatedAt,
    );
  }

  Future<void> upsertAnswer({
    required String uid,
    required String question,
    required String answer,
    required String source,
    required String roleContext,
  }) async {
    final normalized = normalizeQuestion(question);
    final collection = _firestoreService.db
        .collection('users')
        .doc(uid)
        .collection('question_answers');

    final existing = await collection
        .where('normalizedQuestion', isEqualTo: normalized)
        .limit(1)
        .get();

    final payload = <String, dynamic>{
      'question': question.trim(),
      'normalizedQuestion': normalized,
      'answer': answer.trim(),
      'source': source,
      'roleContext': roleContext,
      'updatedAt': DateTime.now(),
    };

    if (existing.docs.isEmpty) {
      await collection.add(payload);
    } else {
      await collection.doc(existing.docs.first.id).set(payload, SetOptions(merge: true));
    }
  }
}
