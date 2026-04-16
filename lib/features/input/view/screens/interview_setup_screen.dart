import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/core/constants/loader_state.dart';
import 'package:prepflow_ai/features/input/notifier/setup_notifier.dart';
import 'package:prepflow_ai/shared/utils/app_toast.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../widgets/resume_upload_card.dart';
import '../widgets/setup_form_section.dart';

class InterviewSetupScreen extends ConsumerWidget {
  const InterviewSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(setupNotifierProvider);
    final isLoading = state.loaderState == LoaderState.loading;

    // Listen for errors
    ref.listen(setupNotifierProvider.select((s) => s.errorMessage), (prev, next) {
      if (next != null) {
        AppToast.showError(context, next);
      }
    });

    // Listen for success
    ref.listen(setupNotifierProvider.select((s) => s.loaderState), (prev, next) {
      if (next == LoaderState.loaded) {
        AppToast.showSuccess(context, 'Analysis complete! Your dashboard is updated.');
        context.go('/dashboard');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interview Setup',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/dashboard');
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Context Extractor',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppSpacing.vSM,
                      Text(
                        'Upload Details. The AI will parse them to build your custom mock preparation blueprint.',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      AppSpacing.vLG,
                      AppGlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ResumeUploadCard(),
                            AppSpacing.vLG,
                            const SetupFormSection(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: AppButton(
                    text: isLoading ? 'Analyzing...' : 'Generate Insights',
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () => ref.read(setupNotifierProvider.notifier).runAnalysis(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
