import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_spacing.dart';
import 'roadmap_item.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        Text(
          'Structured Preparation',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
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
