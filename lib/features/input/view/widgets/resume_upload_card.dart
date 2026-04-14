import 'package:flutter/material.dart';
import '../../../../core/constants/app_spacing.dart';

class ResumeUploadCard extends StatelessWidget {
  const ResumeUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'STEP 1: YOUR RESUME',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        AppSpacing.vMD,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          ),
          child: const Column(
            children: [
              Icon(Icons.cloud_upload_outlined, size: 40),
              AppSpacing.vSM,
              Text(
                'Upload PDF / DOCX',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Max file size 5MB',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
