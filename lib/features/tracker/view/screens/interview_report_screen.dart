import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_gradient_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../widgets/interview_report_question_item.dart';

class InterviewReportScreen extends StatelessWidget {
  const InterviewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Report', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGradientCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: const Text('ATTENDED OCT 10', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.black)),
                  ),
                  AppSpacing.vMD,
                  const Text('Amazon', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black)),
                  const Text('SDE I • Virtual Onsite', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                ],
              ),
            ),
            
            AppSpacing.vLG,
            const Text('Extracted Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            AppSpacing.vMD,
            
            AppGlassCard(
              child: Column(
                children: [
                  InterviewReportQuestionItem(
                    category: 'System Design', 
                    question: 'Design a URL shortener like TinyURL.'
                  ),
                  Divider(color: Theme.of(context).dividerColor, height: 32),
                  InterviewReportQuestionItem(
                    category: 'Behavioral', 
                    question: '"Tell me about a time you disagreed with your manager."'
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
