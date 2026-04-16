import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/mock_interview/notifier/session_notifier.dart';
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
    if (text.isNotEmpty) {
      ref.read(sessionNotifierProvider.notifier).sendMessage(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTyping = ref.watch(sessionNotifierProvider.select((s) => s.isTyping));

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
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.borderColor(context)),
                ),
                child: TextField(
                  controller: _controller,
                  enabled: !isTyping,
                  decoration: InputDecoration(
                    hintText: isTyping ? 'AI is thinking...' : 'Type your answer...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
            ),
            AppSpacing.hSM,
            GestureDetector(
              onTap: isTyping ? null : _handleSend,
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: isTyping ? Colors.grey : AppColors.accentPrimary,
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
