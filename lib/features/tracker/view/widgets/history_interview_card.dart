import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class HistoryInterviewCard extends StatelessWidget {
  final String company;
  final String role;
  final String date;
  final VoidCallback? onTap;

  const HistoryInterviewCard({
    super.key,
    required this.company,
    required this.role,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassCard(
      borderRadius: 20,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          AppSpacing.hMD,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
              ),
              Text('$role • $date', style: TextStyle(fontSize: 14.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
