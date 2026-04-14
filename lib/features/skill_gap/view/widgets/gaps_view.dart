import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'missing_requirements_card.dart';

class GapsView extends StatelessWidget {
  const GapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: const [MissingRequirementsCard()],
    );
  }
}
