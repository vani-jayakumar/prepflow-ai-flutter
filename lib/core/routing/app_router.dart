import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/view/screens/splash_screen.dart';
import '../../features/auth/view/screens/login_screen.dart';
import '../../features/auth/view/screens/register_screen.dart';
import '../../features/dashboard/view/screens/dashboard_screen.dart';
import '../../features/input/view/screens/interview_setup_screen.dart';
import '../../features/skill_gap/view/screens/skill_gap_screen.dart';
import '../../features/questions/view/screens/question_bank_screen.dart';
import '../../features/mock_interview/view/screens/mock_interview_screen.dart';
import '../../features/tracker/view/screens/tracker_screen.dart';
import '../../features/tracker/view/screens/log_upcoming_screen.dart';
import '../../features/tracker/view/screens/log_past_screen.dart';
import '../../features/tracker/view/screens/interview_report_screen.dart';
import '../../features/settings/view/screens/settings_screen.dart';
import '../../features/settings/view/screens/edit_profile_screen.dart';
import '../../shared/widgets/main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/input',
        builder: (context, state) => const InterviewSetupScreen(),
      ),
      
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/bank',
            builder: (context, state) => const QuestionBankScreen(),
          ),
          GoRoute(
            path: '/mock',
            builder: (context, state) => const MockInterviewScreen(),
          ),
          GoRoute(
            path: '/tracker',
            builder: (context, state) => const TrackerScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      
      // Sub-routes (outside bottom nav shell but logically related)
      GoRoute(
        path: '/skillgap',
        builder: (context, state) => const SkillGapScreen(),
      ),
      GoRoute(
        path: '/tracker/add-upcoming',
        builder: (context, state) => const LogUpcomingScreen(),
      ),
      GoRoute(
        path: '/tracker/log-past',
        builder: (context, state) => const LogPastScreen(),
      ),
      GoRoute(
        path: '/tracker/report',
        builder: (context, state) => const InterviewReportScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfileScreen(),
      ),
    ],
  );
});
