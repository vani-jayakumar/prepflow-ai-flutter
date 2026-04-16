import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/firestore_service.dart';
import '../model/session_model.dart';

part 'session_repo.g.dart';

@riverpod
class SessionRepository extends _$SessionRepository {
  @override
  SessionRepo build() {
    return SessionRepo(
      firestoreService: ref.watch(firestoreServiceProvider),
    );
  }
}

abstract class ISessionRepo {
  Future<Either<String, String>> createSession(SessionModel session);
  Future<Either<String, void>> updateSession(String sessionId, Map<String, dynamic> updates);
  Future<Either<String, SessionModel>> getSession(String sessionId);
}

class SessionRepo implements ISessionRepo {
  final FirestoreService _firestoreService;

  SessionRepo({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Future<Either<String, String>> createSession(SessionModel session) async {
    try {
      final docRef = await _firestoreService.db.collection('sessions').add(session.toJson());
      return right(docRef.id);
    } catch (e) {
      return left('Failed to start session: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateSession(String sessionId, Map<String, dynamic> updates) async {
    try {
      await _firestoreService.db.collection('sessions').doc(sessionId).update(updates);
      return right(null);
    } catch (e) {
      return left('Failed to sync session: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, SessionModel>> getSession(String sessionId) async {
    try {
      final doc = await _firestoreService.db.collection('sessions').doc(sessionId).get();
      if (!doc.exists) return left('Session not found');
      
      final data = doc.data()!;
      data['id'] = doc.id;
      return right(SessionModel.fromJson(data));
    } catch (e) {
      return left('Failed to load session: ${e.toString()}');
    }
  }
}
