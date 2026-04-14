import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class SetupFormSection extends StatelessWidget {
  const SetupFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STEP 2: COMPANY & ROLE',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        AppSpacing.vMD,
        const AppTextField(hintText: 'Company Name (e.g. Google)'),
        const AppTextField(hintText: 'Target Title (e.g. Senior iOS Engineer)'),
        const AppTextField(hintText: 'Company/Job Link (Optional)'),
        AppSpacing.vLG,
        Text(
          'STEP 3: JOB DESCRIPTION (JD)',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        AppSpacing.vMD,
        const AppTextField(
          hintText: 'Paste full Job Description here...',
          maxLines: 4,
        ),
      ],
    );
  }
}
