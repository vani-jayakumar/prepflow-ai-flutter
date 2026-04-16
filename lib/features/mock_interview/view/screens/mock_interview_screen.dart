import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/input/notifier/setup_notifier.dart';
import 'package:prepflow_ai/features/mock_interview/notifier/session_notifier.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/interview_input_bar.dart';

class MockInterviewScreen extends ConsumerStatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  ConsumerState<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends ConsumerState<MockInterviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final setupState = ref.read(setupNotifierProvider);
      final roleContext = '${setupState.targetRole} at ${setupState.companyName}';
      ref.read(sessionNotifierProvider.notifier).startNewSession(roleContext);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionNotifierProvider);
    final messages = sessionState.messages;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interview Session',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              itemCount: messages.length + (sessionState.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length) {
                  return const ChatBubble(
                    message: "AI is thinking...",
                    isAI: true,
                  );
                }
                final msg = messages[index];
                return ChatBubble(
                  message: msg.text,
                  isAI: msg.role == 'assistant',
                );
              },
            ),
          ),
          const InterviewInputBar(),
        ],
      ),
    );
  }
}
