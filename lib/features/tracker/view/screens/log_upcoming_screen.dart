import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/features/tracker/model/interview_log_model.dart';
import 'package:prepflow_ai/features/tracker/notifier/tracker_notifier.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class LogUpcomingScreen extends ConsumerStatefulWidget {
  const LogUpcomingScreen({super.key});

  @override
  ConsumerState<LogUpcomingScreen> createState() => _LogUpcomingScreenState();
}

class _LogUpcomingScreenState extends ConsumerState<LogUpcomingScreen> {
  final _companyController = TextEditingController();
  final _roleController = TextEditingController();
  final _jdController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _companyController.dispose();
    _roleController.dispose();
    _jdController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final company = _companyController.text.trim();
    final role = _roleController.text.trim();
    
    if (company.isEmpty || role.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in company and role')),
      );
      return;
    }

    await ref.read(trackerNotifierProvider.notifier).addLog(
      companyName: company,
      role: role,
      dateTime: _selectedDate,
      status: InterviewStatus.upcoming,
    );

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule Interview',
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
              'New Schedule',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
            ),
            AppSpacing.vSM,
            Text(
              'Enter details so AI can build your preparation timeline.',
              style: TextStyle(fontSize: 14.sp),
            ),
            AppSpacing.vLG,
            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BASICS',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  AppTextField(
                    controller: _companyController,
                    hintText: 'Company Name (e.g. Meta)',
                  ),
                  AppTextField(
                    controller: _roleController,
                    hintText: 'Target Role (e.g. Senior Frontend)',
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null && mounted) {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_selectedDate),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _selectedDate = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          });
                        }
                      }
                    },
                    child: AbsorbPointer(
                      child: AppTextField(
                        controller: TextEditingController(
                          text: "${_selectedDate.toLocal()}".split('.')[0].substring(0, 16),
                        ),
                        labelText: 'Date & Time',
                        hintText: 'select',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.vLG,
            AppButton(
              text: 'Save to Planner',
              onPressed: _handleSave,
            ),
          ],
        ),
      ),
    );
  }
}
