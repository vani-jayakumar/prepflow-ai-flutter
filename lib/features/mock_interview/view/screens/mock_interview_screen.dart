import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/core/constants/loader_state.dart';
import 'package:prepflow_ai/shared/widgets/app_empty_state.dart';
import 'package:prepflow_ai/shared/widgets/app_glass_card.dart';
import 'package:prepflow_ai/features/mock_interview/notifier/session_notifier.dart';
import 'package:prepflow_ai/core/constants/app_spacing.dart';
import 'package:prepflow_ai/core/theme/app_text_styles.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/interview_input_bar.dart';

class MockInterviewScreen extends ConsumerStatefulWidget {
  const MockInterviewScreen({super.key});

  @override
  ConsumerState<MockInterviewScreen> createState() =>
      _MockInterviewScreenState();
}

class _MockInterviewScreenState extends ConsumerState<MockInterviewScreen> {
  String? _extractSeedQuestionFromRoute() {
    dynamic extra;
    try {
      extra = GoRouterState.of(context).extra;
    } catch (_) {
      return null;
    }
    if (extra is String && extra.trim().isNotEmpty) {
      return extra.trim();
    }
    if (extra is Map<String, dynamic>) {
      final value = extra['seedQuestion'];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(sessionNotifierProvider.notifier)
          .initializeSession(selectedQuestion: _extractSeedQuestionFromRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionNotifierProvider);
    final messages = sessionState.messages;
    final session = sessionState.currentSession;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interview Session',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            tooltip: 'Restart session',
            onPressed: () =>
                ref.read(sessionNotifierProvider.notifier).restartSession(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: sessionState.loaderState == LoaderState.loading && messages.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : sessionState.loaderState == LoaderState.error && messages.isEmpty
          ? AppEmptyState(
              icon: Icons.mic_off_rounded,
              title: 'Unable to Start Mock Interview',
              description:
                  sessionState.errorMessage ??
                  'Please try again. If this persists, run Generate Insights first.',
              actionLabel: 'Try Again',
              onAction: () =>
                  ref.read(sessionNotifierProvider.notifier).restartSession(),
            )
          : Column(
              children: [
                if (session != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 0),
                    child: AppGlassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Role Context',
                            style: AppTextStyles.captionLarge,
                          ),
                          AppSpacing.vXS,
                          Text(
                            session.roleContext,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    itemCount:
                        messages.length + (sessionState.isTyping ? 1 : 0),
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
