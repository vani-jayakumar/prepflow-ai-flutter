import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/features/settings/notifier/profile_notifier.dart';
import 'package:prepflow_ai/features/input/model/analysis_model.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/score_card.dart';
import '../widgets/skill_gap_preview_card.dart';
import '../widgets/question_bank_preview_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final userState = ref.watch(profileNotifierProvider);
    final user = userState.user;

    // Parse the latest analysis if available
    AnalysisModel? analysis;
    if (user?.lastAnalysis != null) {
      try {
        analysis = AnalysisModel.fromJson(user!.lastAnalysis!);
      } catch (e) {
        // Silently handle parsing errors for now
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getGreeting(user?.displayName),
          style: AppTextStyles.h4.copyWith(
            color: isDarkMode
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: userState.isLoading && user == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                // Future: Implement refresh logic if needed
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScoreCard(
                      score: '${(user?.readinessScore ?? 0).toInt()}%',
                      label: _getScoreLabel(user?.readinessScore ?? 0),
                    ),
                    AppSpacing.vLG,
                    SkillGapPreviewCard(
                      strengths: analysis?.strengths ?? [],
                      skillGaps: analysis?.skillGaps ?? [],
                      onTap: () => context.go('/bank'),
                    ),
                    AppSpacing.vMD,
                    Text(
                      'Up Next For You',
                      style: AppTextStyles.h3.copyWith(
                        color: isDarkMode
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    AppSpacing.vMD,
                    QuestionBankPreviewCard(
                      questionCount: analysis?.interviewQuestions.length ?? 0,
                      onTap: () => context.go('/bank'),
                    ),
                    AppSpacing.vLG,
                    AppButton(
                      text: analysis == null ? 'Get Started' : 'Prepare For A New Role',
                      isSecondary: analysis != null,
                      onPressed: () => context.go('/input'),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
    );
  }

  String _getGreeting(String? name) {
    final hour = DateTime.now().hour;
    String timeOfDay;
    if (hour < 12) {
      timeOfDay = 'Good Morning';
    } else if (hour < 17) {
      timeOfDay = 'Good Afternoon';
    } else {
      timeOfDay = 'Good Evening';
    }

    if (name != null && name.isNotEmpty) {
      return '$timeOfDay, ${name.split(' ')[0]}';
    }
    return timeOfDay;
  }

  String _getScoreLabel(double score) {
    if (score == 0) return 'Not Started';
    if (score >= 90) return 'Exceptional';
    if (score >= 80) return 'Excellent';
    if (score >= 70) return 'Good';
    if (score >= 50) return 'Average';
    return 'Needs Work';
  }
}
