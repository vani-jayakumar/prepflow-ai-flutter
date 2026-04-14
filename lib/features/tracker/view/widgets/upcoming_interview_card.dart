import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_gradient_card.dart';
import '../../../../core/constants/app_spacing.dart';

class UpcomingInterviewCard extends StatelessWidget {
  final String company;
  final String role;
  final String date;
  final String? timeLabel;
  final VoidCallback? onTap;

  const UpcomingInterviewCard({
    super.key,
    required this.company,
    required this.role,
    required this.date,
    this.timeLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppGradientCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                company,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              if (timeLabel != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    timeLabel!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
          AppSpacing.vSM,
          Text(
            '$role • $date',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
