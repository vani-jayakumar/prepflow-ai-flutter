import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/firestore_service.dart';
import '../model/interview_log_model.dart';

part 'tracker_repo.g.dart';

@riverpod
class TrackerRepository extends _$TrackerRepository {
  @override
  TrackerRepo build() {
    return TrackerRepo(
      firestoreService: ref.watch(firestoreServiceProvider),
    );
  }
}

abstract class ITrackerRepo {
  Future<Either<String, void>> addLog(InterviewLogModel log);
  Future<Either<String, void>> updateLog(String logId, Map<String, dynamic> updates);
  Future<Either<String, void>> deleteLog(String logId);
  Stream<List<InterviewLogModel>> watchLogs(String uid);
}

class TrackerRepo implements ITrackerRepo {
  final FirestoreService _firestoreService;

  TrackerRepo({required FirestoreService firestoreService})
      : _firestoreService = firestoreService;

  @override
  Future<Either<String, void>> addLog(InterviewLogModel log) async {
    try {
      await _firestoreService.db.collection('interview_logs').add(log.toJson());
      return right(null);
    } catch (e) {
      return left('Failed to add interview log: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateLog(String logId, Map<String, dynamic> updates) async {
    try {
      await _firestoreService.db.collection('interview_logs').doc(logId).update(updates);
      return right(null);
    } catch (e) {
      return left('Failed to update log: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> deleteLog(String logId) async {
    try {
      await _firestoreService.db.collection('interview_logs').doc(logId).delete();
      return right(null);
    } catch (e) {
      return left('Failed to delete log: ${e.toString()}');
    }
  }

  @override
  Stream<List<InterviewLogModel>> watchLogs(String uid) {
    return _firestoreService.db
        .collection('interview_logs')
        .where('userId', isEqualTo: uid)
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return InterviewLogModel.fromJson(data);
      }).toList();
    });
  }
}
