import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepflow_ai/core/theme/app_colors.dart';
import 'package:prepflow_ai/shared/widgets/app_button.dart';
import 'package:prepflow_ai/shared/widgets/app_glass_card.dart';
import 'package:prepflow_ai/shared/widgets/app_text_field.dart';
import 'package:prepflow_ai/core/constants/app_spacing.dart';
import 'package:prepflow_ai/shared/utils/app_toast.dart';
import 'package:prepflow_ai/features/settings/notifier/profile_notifier.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();

    // Initialize with current data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(profileNotifierProvider).user;
      final authEmail = FirebaseAuth.instance.currentUser?.email;
      if (user != null) {
        _nameController.text = user.displayName ?? '';
        _emailController.text = authEmail ?? user.email;
        _phoneController.text = user.phoneNumber ?? '';
        _bioController.text = user.bio ?? '';
      } else if (authEmail != null) {
        _emailController.text = authEmail;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await ref
          .read(profileNotifierProvider.notifier)
          .uploadAvatar(File(image.path));
    }
  }

  Future<void> _pickResume() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      await ref
          .read(profileNotifierProvider.notifier)
          .uploadResume(File(result.files.single.path!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileNotifierProvider);
    final user = state.user;

    // Handle success/error messages
    ref.listen(profileNotifierProvider.select((s) => s.error), (prev, next) {
      if (next != null) {
        AppToast.showError(context, next);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Information',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      AppGlassCard(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: state.isUploadingAvatar
                                  ? null
                                  : _pickImage,
                              child: Container(
                                width: 80.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28.r),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.accentPrimary,
                                      AppColors.accentSecondary,
                                    ],
                                  ),
                                  image: user?.photoUrl != null
                                      ? DecorationImage(
                                          image: NetworkImage(user!.photoUrl!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: state.isUploadingAvatar
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : user?.photoUrl == null
                                    ? Center(
                                        child: Text(
                                          user?.displayName
                                                  ?.substring(0, 1)
                                                  .toUpperCase() ??
                                              'U',
                                          style: TextStyle(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            AppSpacing.vSM,
                            GestureDetector(
                              onTap: state.isUploadingAvatar
                                  ? null
                                  : _pickImage,
                              child: Text(
                                state.isUploadingAvatar
                                    ? 'Uploading...'
                                    : 'Change Avatar',
                                style: TextStyle(
                                  color: AppColors.accentPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      AppGlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRIMARY INFO',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            AppSpacing.vMD,
                            AppTextField(
                              hintText: 'Full Name',
                              controller: _nameController,
                              labelText: 'Name',
                            ),
                            AppTextField(
                              hintText: 'Email Address',
                              controller: _emailController,
                              labelText: 'Email',
                              enabled: false,
                            ),
                            AppTextField(
                              hintText: 'Phone Number',
                              controller: _phoneController,
                              labelText: 'Phone',
                              keyboardType: TextInputType.phone,
                            ),
                            AppTextField(
                              hintText: 'Tell us a bit about yourself...',
                              controller: _bioController,
                              labelText: 'Bio',
                              maxLines: 3,
                            ),

                            AppSpacing.vLG,
                            Text(
                              'MASTER RESUME',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            AppSpacing.vMD,
                            if (user?.masterResumeUrl != null) ...[
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        user?.masterResumeFileName ??
                                            'Master_Resume.pdf',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 20.r,
                                    ),
                                  ],
                                ),
                              ),
                              AppSpacing.vMD,
                            ],
                            AppButton(
                              text: state.isUploadingResume
                                  ? 'Uploading...'
                                  : user?.masterResumeUrl == null
                                  ? '+ Upload Master Resume'
                                  : 'Update Master Resume',
                              isSecondary: true,
                              isLoading: state.isUploadingResume,
                              onPressed: state.isUploadingResume
                                  ? null
                                  : _pickResume,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
                if (state.isLoading ||
                    state.isUploadingAvatar ||
                    state.isUploadingResume)
                  Container(
                    color: Colors.black26,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
              24.w,
              16.h,
              24.w,
              MediaQuery.of(context).padding.bottom + 16.h,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: AppButton(
              text: state.isLoading ? 'Saving...' : 'Save Changes',
              isLoading: state.isLoading,
              onPressed: state.isLoading
                  ? null
                  : () async {
                      await ref
                          .read(profileNotifierProvider.notifier)
                          .updateProfile(
                            displayName: _nameController.text,
                            bio: _bioController.text,
                            phoneNumber: _phoneController.text,
                          );
                      if (context.mounted) {
                        AppToast.showSuccess(
                          context,
                          'Profile updated successfully!',
                        );
                        context.pop();
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
