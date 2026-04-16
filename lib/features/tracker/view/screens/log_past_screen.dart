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
import '../widgets/log_question_item.dart';
import '../widgets/outcome_chip.dart';
import '../../../../core/theme/app_colors.dart';

class LogPastScreen extends ConsumerStatefulWidget {
  const LogPastScreen({super.key});

  @override
  ConsumerState<LogPastScreen> createState() => _LogPastScreenState();
}

class _LogPastScreenState extends ConsumerState<LogPastScreen> {
  final _companyController = TextEditingController();
  final _roleController = TextEditingController();
  final _questionController = TextEditingController();
  final List<String> _questions = [];
  DateTime _selectedDate = DateTime.now();
  InterviewStatus _status = InterviewStatus.completed;

  @override
  void dispose() {
    _companyController.dispose();
    _roleController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _addQuestion() {
    final text = _questionController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _questions.add(text);
        _questionController.clear();
      });
    }
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
      status: _status,
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
                  Text(
                    'INTERVIEW META',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  AppTextField(
                    controller: _companyController,
                    hintText: 'Company Name (e.g. Amazon)',
                  ),
                  AppTextField(
                    controller: _roleController,
                    hintText: 'Role (e.g. SDE I)',
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 365 * 10)),
                        lastDate: DateTime.now(),
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
                  AppSpacing.vLG,
                  Text(
                    'QUESTIONS THEY ASKED',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.accentPrimary,
                    ),
                  ),
                  AppSpacing.vXS,
                  Text(
                    'Add the technical or behavioral questions you remember.',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  AppSpacing.vMD,
                  ..._questions.map((q) => LogQuestionItem(text: q)),
                  AppSpacing.vMD,
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _questionController,
                          hintText: 'Type a new question...',
                        ),
                      ),
                      AppSpacing.hMD,
                      SizedBox(
                        width: 80.w,
                        child: AppButton(
                          text: 'Add',
                          onPressed: _addQuestion,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.vLG,
                  Text(
                    'OUTCOME',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  AppSpacing.vMD,
                  Wrap(
                    spacing: 8.w,
                    children: [
                      OutcomeChip(
                        label: 'Offer Received',
                        isActive: _status == InterviewStatus.offered,
                        onTap: () => setState(() => _status = InterviewStatus.offered),
                      ),
                      OutcomeChip(
                        label: 'Rejected',
                        isActive: _status == InterviewStatus.rejected,
                        onTap: () => setState(() => _status = InterviewStatus.rejected),
                      ),
                      OutcomeChip(
                        label: 'Waiting',
                        isActive: _status == InterviewStatus.completed,
                        onTap: () => setState(() => _status = InterviewStatus.completed),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.vLG,
            AppButton(
              text: 'Commit to Study Bank',
              onPressed: _handleSave,
            ),
          ],
        ),
      ),
    );
  }
}
