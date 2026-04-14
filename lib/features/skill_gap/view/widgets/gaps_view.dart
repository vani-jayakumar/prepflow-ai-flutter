import 'package:flutter/material.dart';
import 'missing_requirements_card.dart';

class GapsView extends StatelessWidget {
  const GapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: const [
        MissingRequirementsCard(),
      ],
    );
  }
}
