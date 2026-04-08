import 'package:flutter/material.dart';

class QuestionTabItem extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const QuestionTabItem({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).colorScheme.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive 
                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 12, offset: const Offset(0, 4))] 
                : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Theme.of(context).colorScheme.onSurface : Theme.of(context).disabledColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
