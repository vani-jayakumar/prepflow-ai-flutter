import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_gradient_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/interview_input_bar.dart';

class MockInterviewScreen extends StatelessWidget {
  const MockInterviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Session', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                AppGradientCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Backend System Design'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
                          letterSpacing: 1.1,
                        ),
                      ),
                      AppSpacing.vSM,
                      const Text(
                        'How do you scale a Django application for millions of users?',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, height: 1.4),
                      ),
                    ],
                  ),
                ),
                AppSpacing.vLG,
                const ChatBubble(
                  message: "I'm acting as a Senior Engineering Manager at Google. Let's begin.",
                  isAI: true,
                ),
                const ChatBubble(
                  message: "Sure, I'd start by analyzing the current bottlenecks, likely in the database layer or blocking I/O operations.",
                  isAI: false,
                ),
              ],
            ),
          ),
          const InterviewInputBar(),
        ],
      ),
    );
  }
}
