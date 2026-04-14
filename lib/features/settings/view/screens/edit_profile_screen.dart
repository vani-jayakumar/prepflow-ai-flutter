import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Information',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            AppGlassCard(
              child: Column(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.r),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.accentPrimary,
                          AppColors.accentSecondary,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'VS',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.vSM,
                  Text(
                    'Change Avatar',
                    style: TextStyle(
                      color: AppColors.accentPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),

            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PRIMARY INFO',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  const AppTextField(hintText: 'Full Name'),
                  const AppTextField(hintText: 'Email Address'),
                  const AppTextField(
                    hintText: 'Phone Number',
                    keyboardType: TextInputType.phone,
                  ),

                  AppSpacing.vLG,
                  Text(
                    'MASTER RESUME',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vani_Resume_Oct.pdf',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.vMD,
                  AppButton(
                    text: '+ Upload New Master Resume',
                    isSecondary: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            AppButton(text: 'Save Changes', onPressed: () => context.pop()),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
