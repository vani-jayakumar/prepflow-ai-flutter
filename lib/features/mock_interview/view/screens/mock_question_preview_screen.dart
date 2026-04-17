import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/services/ai_service.dart';
import '../../../../core/services/web_answer_service.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../auth/notifier/auth_notifier.dart';
import '../../../input/model/analysis_model.dart';
import '../../../input/notifier/setup_notifier.dart';
import '../../repo/question_answer_cache_repo.dart';
import '../../../settings/notifier/profile_notifier.dart';

/// In-memory cache entry for question answers.
class MemoryAnswer {
  final String answer;
  final String source;

  const MemoryAnswer({
    required this.answer,
    required this.source,
  });
}

class MockQuestionPreviewScreen extends ConsumerStatefulWidget {
  const MockQuestionPreviewScreen({super.key});

  @override
  ConsumerState<MockQuestionPreviewScreen> createState() =>
      _MockQuestionPreviewScreenState();
}

class _MockQuestionPreviewScreenState
    extends ConsumerState<MockQuestionPreviewScreen> {
  static final Map<String, MemoryAnswer> _answerCache = {};

  String? _question;
  String? _answer;
  bool _isLoading = true;
  bool _isRefreshingAi = false;
  bool _isRetryingWeb = false;
  bool _usedFallback = false;
  String _source = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAnswer();
    });
  }

  String? _extractQuestionFromRoute() {
    dynamic extra;
    try {
      extra = GoRouterState.of(context).extra;
    } catch (_) {
      return null;
    }

    if (extra is String && extra.trim().isNotEmpty) {
      return extra.trim();
    }

    if (extra is Map<String, dynamic>) {
      final value = extra['question'];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }

  Future<void> _loadAnswer() async {
    final question = _extractQuestionFromRoute();
    if (question == null) {
      setState(() {
        _question = null;
        _answer = null;
        _isLoading = false;
        _usedFallback = false;
        _source = '';
      });
      return;
    }

    setState(() {
      _question = question;
      _isLoading = true;
      _usedFallback = false;
      _source = '';
    });

    final cacheKey = question.trim().toLowerCase();
    final memoryCached = _answerCache[cacheKey];
    if (memoryCached != null) {
      setState(() {
        _answer = memoryCached.answer;
        _isLoading = false;
        _usedFallback = memoryCached.source == 'fallback';
        _source = memoryCached.source;
      });
      return;
    }

    final roleContext = _buildRoleContext();
    final uid = _currentUserId();

    // Step 1: Check Firestore cache first (no AI tokens used)
    if (uid != null) {
      try {
        final firestoreCached = await ref
            .read(questionAnswerCacheRepoProvider)
            .getCachedAnswer(uid: uid, question: question);
        if (firestoreCached != null) {
          _answerCache[cacheKey] = MemoryAnswer(
            answer: firestoreCached.answer,
            source: 'cache_${firestoreCached.source}',
          );

          if (!mounted) return;
          setState(() {
            _answer = firestoreCached.answer;
            _isLoading = false;
            _usedFallback = firestoreCached.source == 'fallback';
            _source = firestoreCached.source;
          });
          return;
        }
      } catch (_) {}
    }

    // Step 2: Cache miss - fetch from web (StackOverflow/DuckDuckGo) - no AI tokens
    final webAnswer = await ref.read(webAnswerServiceProvider).fetchAnswer(
          question,
        );
    if (webAnswer.trim().isNotEmpty) {
      final clean = webAnswer.trim();
      _answerCache[cacheKey] = MemoryAnswer(answer: clean, source: 'web');

      // Store in Firestore for future cache hits
      if (uid != null) {
        try {
          await ref.read(questionAnswerCacheRepoProvider).upsertAnswer(
                uid: uid,
                question: question,
                answer: clean,
                source: 'web',
                roleContext: roleContext,
              );
        } catch (_) {}
      }

      if (!mounted) return;
      setState(() {
        _answer = clean;
        _isLoading = false;
        _usedFallback = false;
        _source = 'web';
      });
      return;
    }

    // Step 3: Web unavailable - use fallback template (still no AI tokens)
    final fallback = _fallbackAnswer(question: question);
    _answerCache[cacheKey] = MemoryAnswer(answer: fallback, source: 'fallback');

    if (uid != null) {
      try {
        await ref.read(questionAnswerCacheRepoProvider).upsertAnswer(
              uid: uid,
              question: question,
              answer: fallback,
              source: 'fallback',
              roleContext: roleContext,
            );
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() {
      _answer = fallback;
      _isLoading = false;
      _usedFallback = true;
      _source = 'fallback';
    });
  }

  Future<void> _retryWebFetch() async {
    final question = _question;
    if (question == null || question.trim().isEmpty || _isRetryingWeb) return;

    setState(() {
      _isRetryingWeb = true;
    });

    final roleContext = _buildRoleContext();
    final cacheKey = question.trim().toLowerCase();
    final uid = _currentUserId();

    try {
      final webAnswer = await ref.read(webAnswerServiceProvider).fetchAnswer(question);
      if (webAnswer.trim().isEmpty) {
        throw Exception('Empty web answer');
      }

      final clean = webAnswer.trim();
      _answerCache[cacheKey] = MemoryAnswer(answer: clean, source: 'web');

      if (uid != null) {
        try {
          await ref.read(questionAnswerCacheRepoProvider).upsertAnswer(
                uid: uid,
                question: question,
                answer: clean,
                source: 'web',
                roleContext: roleContext,
              );
        } catch (_) {}
      }

      if (!mounted) return;
      setState(() {
        _answer = clean;
        _usedFallback = false;
        _source = 'web';
        _isRetryingWeb = false;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Web fetch still unavailable. You can try AI refresh.'),
        ),
      );
      setState(() {
        _isRetryingWeb = false;
      });
    }
  }

  Future<void> _refreshWithAi() async {
    final question = _question;
    if (question == null || question.trim().isEmpty || _isRefreshingAi) return;

    setState(() {
      _isRefreshingAi = true;
    });

    final roleContext = _buildRoleContext();
    final cacheKey = question.trim().toLowerCase();
    final uid = _currentUserId();

    try {
      final generated = await ref.read(aiServiceProvider).generateQuestionAnswer(
            question: question,
            roleContext: roleContext,
          );

      if (generated.trim().isEmpty) {
        throw Exception('Empty AI answer');
      }

      final clean = generated.trim();
      _answerCache[cacheKey] = MemoryAnswer(answer: clean, source: 'ai');

      if (uid != null) {
        try {
          await ref.read(questionAnswerCacheRepoProvider).upsertAnswer(
                uid: uid,
                question: question,
                answer: clean,
                source: 'ai',
                roleContext: roleContext,
              );
        } catch (_) {}
      }

      if (!mounted) return;
      setState(() {
        _answer = clean;
        _usedFallback = false;
        _source = 'ai';
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('AI refresh failed. Keeping existing answer.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshingAi = false;
        });
      }
    }
  }

  String? _currentUserId() {
    final authUid = ref.read(authNotifierProvider).user?.uid;
    if (authUid != null && authUid.isNotEmpty) return authUid;

    try {
      return FirebaseAuth.instance.currentUser?.uid;
    } catch (_) {
      return null;
    }
  }

  String _buildRoleContext() {
    final setupState = ref.read(setupNotifierProvider);
    final role = setupState.targetRole.trim();
    final company = setupState.companyName.trim();

    if (role.isNotEmpty && company.isNotEmpty) return '$role at $company';
    if (role.isNotEmpty) return role;
    if (company.isNotEmpty) return 'Interview at $company';

    final rawAnalysis = ref.read(profileNotifierProvider).user?.lastAnalysis;
    if (rawAnalysis != null) {
      try {
        final analysis = AnalysisModel.fromJson(rawAnalysis);
        final focus = analysis.focusAreas
            .map((f) => f.trim())
            .where((f) => f.isNotEmpty)
            .take(2)
            .toList();
        if (focus.isNotEmpty) {
          return 'Software Engineer Interview (${focus.join(', ')})';
        }
      } catch (_) {}
    }

    return 'Software Engineer Interview';
  }

  bool _isBehavioralQuestion(String question) {
    final normalized = question.toLowerCase();
    const hints = [
      'tell me about',
      'how do you handle',
      'how did you',
      'conflict',
      'team',
      'lead',
      'challenge',
      'mistake',
      'feedback',
      'stakeholder',
    ];
    return hints.any(normalized.contains);
  }

  String _fallbackAnswer({required String question}) {
    if (_isBehavioralQuestion(question)) {
      return 'Situation: In my previous role, I faced a challenge relevant to this topic.\n\n'
          'Task: I needed to take ownership, align stakeholders, and deliver on time.\n\n'
          'Action: I broke the work into milestones, communicated trade-offs clearly, and proactively removed blockers with my team.\n\n'
          'Result: We delivered successfully, improved reliability, and I documented learnings to scale the process.';
    }

    return 'Approach: I would first clarify requirements, constraints, and success metrics, then design a simple and scalable solution incrementally.\n\n'
        'Trade-offs: I would compare complexity, performance, maintainability, and cost before finalizing architecture decisions.\n\n'
        'Example: In a similar project, I started with a straightforward baseline, added observability, and then optimized the bottleneck path using profiling data.';
  }

  @override
  Widget build(BuildContext context) {
    final question = _question;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question Preview',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: question == null
          ? AppEmptyState(
              icon: Icons.help_outline_rounded,
              title: 'Question Not Found',
              description:
                  'Open a question from Question Bank to view a sample answer.',
              actionLabel: 'Go To Question Bank',
              onAction: () => context.go('/bank'),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Question',
                                style: AppTextStyles.captionLarge,
                              ),
                              AppSpacing.vSM,
                              Text(question, style: AppTextStyles.h3),
                            ],
                          ),
                        ),
                        AppGlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Sample Answer',
                                    style: AppTextStyles.captionLarge,
                                  ),
                                  const Spacer(),
                                  if (!_isLoading)
                                    TextButton(
                                      onPressed: _isRefreshingAi ? null : _refreshWithAi,
                                      child: _isRefreshingAi
                                          ? SizedBox(
                                              width: 14.r,
                                              height: 14.r,
                                              child: const CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.auto_awesome_outlined,
                                                  size: 16.r,
                                                ),
                                                AppSpacing.hXS,
                                                const Text('Refresh with AI'),
                                              ],
                                            ),
                                    ),
                                  if (_isLoading)
                                    SizedBox(
                                      width: 18.r,
                                      height: 18.r,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                ],
                              ),
                              AppSpacing.vSM,
                              Text(
                                _isLoading
                                    ? 'Fetching best available web answer...'
                                    : (_answer ?? ''),
                                style: AppTextStyles.body,
                              ),
                              if (_usedFallback) ...[
                                AppSpacing.vSM,
                                Text(
                                  'Web answer unavailable. Showing a reliable fallback template.',
                                  style: AppTextStyles.caption.copyWith(
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                              ],
                              if (!_isLoading && _source.isNotEmpty) ...[
                                AppSpacing.vSM,
                                Row(
                                  children: [
                                    Icon(
                                      _source == 'ai'
                                          ? Icons.auto_awesome
                                          : _source == 'web'
                                              ? Icons.public
                                              : Icons.info_outline,
                                      size: 14.r,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    AppSpacing.hXS,
                                    Text(
                                      _source == 'ai'
                                          ? 'AI-generated answer (uses tokens)'
                                          : _source == 'web'
                                              ? 'Answer from web search'
                                              : _source == 'fallback'
                                                  ? 'Fallback template'
                                                  : _source.startsWith('cache_')
                                                      ? 'Cached (${_source.replaceFirst('cache_', '')})'
                                                      : 'Source: ${_source.replaceAll('_', ' ')}',
                                      style: AppTextStyles.caption.copyWith(
                                        color: Theme.of(context).disabledColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                  child: AppButton(
                    text: 'Let\'s Start Mock Interview',
                    onPressed: () => context.push(
                      '/mock/live',
                      extra: {'seedQuestion': question},
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}