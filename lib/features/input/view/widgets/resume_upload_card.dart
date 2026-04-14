import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_spacing.dart';

class ResumeUploadCard extends StatelessWidget {
  const ResumeUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STEP 1: YOUR RESUME',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        AppSpacing.vMD,
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 40.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          ),
          child: Column(
            children: [
              Icon(Icons.cloud_upload_outlined, size: 40.r),
              AppSpacing.vSM,
              Text(
                'Upload PDF / DOCX',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Text('Max file size 5MB', style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ),
      ],
    );
  }
}
