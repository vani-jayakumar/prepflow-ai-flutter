import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/input/notifier/setup_notifier.dart';
import 'package:prepflow_ai/features/settings/notifier/profile_notifier.dart';
import 'package:prepflow_ai/shared/widgets/app_switch.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class ResumeUploadCard extends ConsumerWidget {
  const ResumeUploadCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setupState = ref.watch(setupNotifierProvider);
    final profileState = ref.watch(profileNotifierProvider);
    final user = profileState.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'YOUR RESUME',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            if (user?.masterResumeUrl != null)
              Row(
                children: [
                  Text(
                    'Use Master',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.accentPrimary),
                  ),
                  SizedBox(width: 8.w),
                  AppSwitch(
                    value: setupState.useMasterResume,
                    onChanged: (val) => ref.read(setupNotifierProvider.notifier).toggleUseMasterResume(val),
                  ),
                ],
              ),
          ],
        ),
        AppSpacing.vMD,
        if (setupState.useMasterResume && user?.masterResumeUrl != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.accentPrimary, width: 1.5.w),
              color: AppColors.accentPrimary.withValues(alpha: 0.1),
            ),
            child: Row(
              children: [
                Icon(Icons.description_rounded, color: AppColors.accentPrimary, size: 24.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    user?.masterResumeFileName ?? 'Master_Resume.pdf',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                ),
                Icon(Icons.check_circle, color: AppColors.accentPrimary, size: 20.r),
              ],
            ),
          )
        else
          GestureDetector(
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
              if (result != null && result.files.single.path != null) {
                ref.read(setupNotifierProvider.notifier).selectResumeFile(File(result.files.single.path!));
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                border: setupState.selectedResume != null 
                    ? Border.all(color: AppColors.accentPrimary, width: 1.5.w)
                    : null,
              ),
              child: Column(
                children: [
                  Icon(
                    setupState.selectedResume != null ? Icons.file_present_rounded : Icons.cloud_upload_outlined,
                    size: 32.r,
                    color: setupState.selectedResume != null ? AppColors.accentPrimary : null,
                  ),
                  AppSpacing.vSM,
                  Text(
                    setupState.selectedResume != null 
                        ? setupState.selectedResume!.path.split('/').last 
                        : 'Upload PDF',
                    style: TextStyle(
                      fontSize: 14.sp, 
                      fontWeight: FontWeight.w600,
                      color: setupState.selectedResume != null ? AppColors.accentPrimary : null,
                    ),
                  ),
                  if (setupState.selectedResume == null)
                    Text('Max file size 5MB', style: TextStyle(fontSize: 11.sp)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
