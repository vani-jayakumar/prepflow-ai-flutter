import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';
import '../widgets/log_question_item.dart';
import '../widgets/outcome_chip.dart';

import '../../../../core/theme/app_colors.dart';

class LogPastScreen extends StatelessWidget {
  const LogPastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Log Interview',
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
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log Past Interview',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
            AppSpacing.vSM,
            Text(
              'Feed real questions into your Brain to improve future mocks.',
              style: TextStyle(fontSize: 14.sp),
            ),
            AppSpacing.vLG,

            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'INTERVIEW META',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  const AppTextField(hintText: 'Company Name (e.g. Amazon)'),
                  const AppTextField(hintText: 'Role (e.g. SDE I)'),

                  AppSpacing.vLG,
                  const Text(
                    'QUESTIONS THEY ASKED',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.accentPrimary,
                    ),
                  ),
                  AppSpacing.vXS,
                  const Text(
                    'Add the technical or behavioral questions you remember.',
                    style: TextStyle(fontSize: 14),
                  ),
                  AppSpacing.vMD,

                  const LogQuestionItem(text: 'What is a Bloom Filter?'),
                  const LogQuestionItem(
                    text: 'Design a distributed rate limiter.',
                  ),

                  AppSpacing.vMD,
                  Row(
                    children: [
                      const Expanded(
                        child: AppTextField(hintText: 'Type a new question...'),
                      ),
                      AppSpacing.hMD,
                      SizedBox(
                        width: 80,
                        child: AppButton(text: 'Add', onPressed: () {}),
                      ),
                    ],
                  ),

                  AppSpacing.vLG,
                  const Text(
                    'OUTCOME',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  const Wrap(
                    spacing: 8,
                    children: [
                      OutcomeChip(label: 'Offer Received'),
                      OutcomeChip(label: 'Rejected'),
                      OutcomeChip(label: 'Waiting', isActive: true),
                    ],
                  ),
                ],
              ),
            ),

            AppButton(
              text: 'Commit to Study Bank',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
