import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/roadmap_item.dart';

class SkillGapScreen extends StatefulWidget {
  const SkillGapScreen({super.key});

  @override
  State<SkillGapScreen> createState() => _SkillGapScreenState();
}

class _SkillGapScreenState extends State<SkillGapScreen> with SingleTickerProviderStateMixin {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deep Analysis', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4)),
                  ],
                ),
                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(context).disabledColor,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Identifying Gaps'),
                  Tab(text: 'AI Roadmap'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGapsView(context),
                _buildRoadmapView(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGapsView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        AppGlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('!', style: TextStyle(color: AppColors.danger, fontSize: 20, fontWeight: FontWeight.w800)),
                  AppSpacing.hSM,
                  const Text('Missing Requirements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
              AppSpacing.vSM,
              const Text('Core elements asked by employer, missing from resume.', style: TextStyle(fontSize: 14)),
              AppSpacing.vMD,
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppChip(label: 'GraphQL APIs', type: ChipType.weak),
                  AppChip(label: 'Docker Containerization', type: ChipType.weak),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoadmapView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const Text('Structured Preparation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        AppSpacing.vLG,
        const RoadmapItem(
          title: 'Mastering System Design',
          subtitle: 'Focus on caching and database splitting.',
          label: 'Up Next • Day 2-3',
        ),
      ],
    );
  }
}
