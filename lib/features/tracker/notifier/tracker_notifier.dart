import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/constants/loader_state.dart';
import '../../auth/notifier/auth_notifier.dart';
import '../model/interview_log_model.dart';
import '../repo/tracker_repo.dart';
import '../state/tracker_state.dart';

part 'tracker_notifier.g.dart';

@riverpod
class TrackerNotifier extends _$TrackerNotifier {
  StreamSubscription? _logsSubscription;

  @override
  TrackerState build() {
    ref.onDispose(() => _logsSubscription?.cancel());
    Future.microtask(_initLogs);
    return const TrackerState();
  }

  void _initLogs() {
    final authState = ref.read(authNotifierProvider);
    final user = authState.user;
    if (user == null) return;

    state = state.copyWith(loaderState: LoaderState.loading);

    final repo = ref.read(trackerRepositoryProvider);
    _logsSubscription = repo.watchLogs(user.uid).listen((logs) {
      final now = DateTime.now();
      
      final upcoming = logs.where((l) => 
        l.status == InterviewStatus.upcoming && l.dateTime.isAfter(now)
      ).toList();

      final history = logs.where((l) => 
        l.status != InterviewStatus.upcoming || l.dateTime.isBefore(now)
      ).toList();

      state = state.copyWith(
        upcomingLogs: upcoming,
        historyLogs: history,
        loaderState: LoaderState.loaded,
      );
    }, onError: (error) {
      state = state.copyWith(
        loaderState: LoaderState.error,
        errorMessage: error.toString(),
      );
    });
  }

  Future<void> addLog({
    required String companyName,
    required String role,
    required DateTime dateTime,
    required InterviewStatus status,
  }) async {
    final user = ref.read(authNotifierProvider).user;
    if (user == null) return;

    final repo = ref.read(trackerRepositoryProvider);
    final log = InterviewLogModel(
      userId: user.uid,
      companyName: companyName,
      role: role,
      dateTime: dateTime,
      status: status,
      createdAt: DateTime.now(),
    );

    final result = await repo.addLog(log);
    result.fold(
      (error) => state = state.copyWith(errorMessage: error),
      (_) => null, // State will update via stream
    );
  }

  Future<void> deleteLog(String logId) async {
    final repo = ref.read(trackerRepositoryProvider);
    final result = await repo.deleteLog(logId);
    result.fold(
      (error) => state = state.copyWith(errorMessage: error),
      (_) => null,
    );
  }
}
