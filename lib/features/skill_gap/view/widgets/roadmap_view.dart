import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';
import 'roadmap_item.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: const [
        Text('Structured Preparation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        AppSpacing.vLG,
        RoadmapItem(
          title: 'Mastering System Design',
          subtitle: 'Focus on caching and database splitting.',
          label: 'Up Next • Day 2-3',
        ),
      ],
    );
  }
}
