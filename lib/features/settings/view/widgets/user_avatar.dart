import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const UserAvatar({super.key, required this.initials, this.size = 90});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        gradient: const LinearGradient(
          colors: [Color(0xFFA78BFA), Color(0xFF34D399)],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: (size.w) * 0.35,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
