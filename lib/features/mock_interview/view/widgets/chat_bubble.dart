import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isAI;

  const ChatBubble({super.key, required this.message, required this.isAI});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isAI
              ? Theme.of(context).colorScheme.surface
              : const Color(0xFFFDBA74),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: Radius.circular(isAI ? 4.r : 20.r),
            bottomRight: Radius.circular(isAI ? 20.r : 4.r),
          ),
          border: isAI
              ? Border.all(color: Theme.of(context).dividerColor)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isAI
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
