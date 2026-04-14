import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class InterviewInputBar extends StatelessWidget {
  const InterviewInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.borderColor(context)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your answer...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                ),
              ),
            ),
            AppSpacing.hSM,
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: const BoxDecoration(
                color: AppColors.accentPrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: Colors.white, size: 20.r),
            ),
          ],
        ),
      ),
    );
  }
}
