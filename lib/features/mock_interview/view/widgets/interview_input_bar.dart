import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/mock_interview/notifier/session_notifier.dart';
import 'package:prepflow_ai/core/constants/loader_state.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class InterviewInputBar extends ConsumerStatefulWidget {
  const InterviewInputBar({super.key});

  @override
  ConsumerState<InterviewInputBar> createState() => _InterviewInputBarState();
}

class _InterviewInputBarState extends ConsumerState<InterviewInputBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    final sessionState = ref.read(sessionNotifierProvider);
    final canSend =
        !sessionState.isTyping &&
        sessionState.currentSession != null &&
        sessionState.loaderState != LoaderState.loading;
    if (text.isNotEmpty && canSend) {
      ref.read(sessionNotifierProvider.notifier).sendMessage(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionState = ref.watch(sessionNotifierProvider);
    final isTyping = sessionState.isTyping;
    final canSend =
        !isTyping &&
        sessionState.currentSession != null &&
        sessionState.loaderState != LoaderState.loading;
    final hintText = isTyping
        ? 'AI is thinking...'
        : sessionState.currentSession == null
        ? 'Starting interview...'
        : 'Type your answer...';

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: TextField(
                  controller: _controller,
                  enabled: canSend,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
            ),
            AppSpacing.hSM,
            GestureDetector(
              onTap: canSend ? _handleSend : null,
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: canSend ? AppColors.accentPrimary : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.send, color: Colors.white, size: 20.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
