import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/input/notifier/setup_notifier.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class SetupFormSection extends ConsumerStatefulWidget {
  const SetupFormSection({super.key});

  @override
  ConsumerState<SetupFormSection> createState() => _SetupFormSectionState();
}

class _SetupFormSectionState extends ConsumerState<SetupFormSection> {
  late TextEditingController _jdController;
  late TextEditingController _companyController;
  late TextEditingController _roleController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(setupNotifierProvider);
    _jdController = TextEditingController(text: state.jobDescription);
    _companyController = TextEditingController(text: state.companyName);
    _roleController = TextEditingController(text: state.targetRole);
  }

  @override
  void dispose() {
    _jdController.dispose();
    _companyController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Role',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        AppSpacing.vSM,
        AppTextField(
          hintText: 'e.g. Senior Product Designer',
          controller: _roleController,
          onChanged: (val) => ref.read(setupNotifierProvider.notifier).updateCompanyDetails(role: val),
        ),
        AppSpacing.vMD,
        Text(
          'Company Name',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        AppSpacing.vSM,
        AppTextField(
          hintText: 'e.g. Google, Airbnb',
          controller: _companyController,
          onChanged: (val) => ref.read(setupNotifierProvider.notifier).updateCompanyDetails(name: val),
        ),
        AppSpacing.vMD,
        Text(
          'Job Description',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        AppSpacing.vSM,
        AppTextField(
          hintText: 'Paste the job requirements here...',
          maxLines: 5,
          controller: _jdController,
          onChanged: (val) => ref.read(setupNotifierProvider.notifier).updateJobDescription(val),
        ),
      ],
    );
  }
}
