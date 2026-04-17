import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class RoadmapItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;

  const RoadmapItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: AppColors.separatorColor(context), width: 3),
        ),
      ),
      padding: EdgeInsets.only(left: 20.w, bottom: 24.h),
      margin: EdgeInsets.only(left: 12.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -28.5.w,
            top: 0,
            child: Container(
              width: 14.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accentPrimary, width: 3.w),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.accentPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.vXS,
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              AppSpacing.vXS,
              Text(subtitle, style: TextStyle(fontSize: 14.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
