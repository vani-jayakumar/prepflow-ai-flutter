import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/features/settings/notifier/profile_notifier.dart';
import '../../../input/model/analysis_model.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../widgets/gaps_view.dart';
import '../widgets/roadmap_view.dart';

class SkillGapScreen extends ConsumerStatefulWidget {
  const SkillGapScreen({super.key});

  @override
  ConsumerState<SkillGapScreen> createState() => _SkillGapScreenState();
}

class _SkillGapScreenState extends ConsumerState<SkillGapScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);
    final user = profileState.user;

    AnalysisModel? analysis;
    if (user?.lastAnalysis != null) {
      try {
        analysis = AnalysisModel.fromJson(user!.lastAnalysis!);
      } catch (_) {
        analysis = null;
      }
    }

    final hasInsights = analysis != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deep Analysis',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/dashboard');
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: hasInsights
          ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      labelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      labelColor: Theme.of(context).colorScheme.onSurface,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: 'Complete Insights'),
                        Tab(text: 'AI Roadmap'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      GapsView(
                        readinessScore: analysis.readinessScore,
                        matchLabel: analysis.matchLabel,
                        strengths: analysis.strengths,
                        skillGaps: analysis.skillGaps,
                        focusAreas: analysis.focusAreas,
                      ),
                      RoadmapView(roadmap: analysis.roadmap),
                    ],
                  ),
                ),
              ],
            )
          : AppEmptyState(
              icon: Icons.insights_rounded,
              title: 'No Insights Yet',
              description:
                  'Run a new AI analysis to view your complete skill-gap report and roadmap.',
              actionLabel: 'Generate Insights',
              onAction: () => context.go('/input'),
            ),
    );
  }
}
