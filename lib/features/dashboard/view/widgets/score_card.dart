import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_gradient_card.dart';

class ScoreCard extends StatelessWidget {
  final String score;
  final String label;

  const ScoreCard({super.key, required this.score, required this.label});

  @override
  Widget build(BuildContext context) {
    return AppGradientCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'READINESS SCORE',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              score,
              style: TextStyle(
                fontSize: 56.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -2,
                color: Colors.white,
                height: 1,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.trending_up_rounded,
                    size: 16.r,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
