import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_gradient_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Interview Lifecycle', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
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
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                ],
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
                  Tab(text: 'Upcoming'),
                  Tab(text: 'History'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUpcomingView(context),
                _buildHistoryView(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        AppButton(
          text: '+ Add Upcoming Interview',
          isSecondary: true,
          onPressed: () => context.push('/tracker/add-upcoming'),
        ),
        AppSpacing.vMD,
        AppGradientCard(
          onTap: () => context.go('/input'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Google', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: const Text('IN 2 DAYS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black)),
                  ),
                ],
              ),
              AppSpacing.vSM,
              const Text('SWE L4 • Oct 10, 2:00 PM', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        AppButton(
          text: '+ Log Past Interview Details',
          isSecondary: true,
          onPressed: () => context.push('/tracker/log-past'),
        ),
        AppSpacing.vMD,
        AppGlassCard(
          borderRadius: 20,
          onTap: () => context.push('/tracker/report'),
          child: Row(
            children: [
              Container(width: 4, height: 40, decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(2))),
              AppSpacing.hMD,
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amazon', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text('SDE I • Oct 1st', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
