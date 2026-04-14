import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isAI;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isAI,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        decoration: BoxDecoration(
          color: isAI ? Theme.of(context).colorScheme.surface : const Color(0xFFFDBA74),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isAI ? 4 : 20),
            bottomRight: Radius.circular(isAI ? 20 : 4),
          ),
          border: isAI ? Border.all(color: Theme.of(context).dividerColor) : null,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isAI ? Theme.of(context).textTheme.bodyLarge?.color : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
