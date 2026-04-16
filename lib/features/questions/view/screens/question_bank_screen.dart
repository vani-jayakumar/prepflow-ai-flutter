import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/questions/notifier/question_notifier.dart';
import '../widgets/question_list_view.dart';
import '../../../../shared/widgets/app_chip.dart';

class QuestionBankScreen extends ConsumerStatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  ConsumerState<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends ConsumerState<QuestionBankScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(questionNotifierProvider);

    // Filter universal questions by tags (mock behavior for now)
    final technical = state.universalQuestions.where((q) => q.tags.contains('Technical')).toList();
    final behavioral = state.universalQuestions.where((q) => q.tags.contains('Behavioral')).toList();
    final personalized = state.personalizedQuestions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Question Bank',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withValues(alpha: isDarkMode ? 0.4 : 0.8),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: isDarkMode
                      ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.5)
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(context).disabledColor,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Personalized'),
                  Tab(text: 'Technical'),
                  Tab(text: 'Behavioral'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                QuestionListView(
                  questions: personalized.map((q) => {
                    'title': q.text,
                    'tags': q.tags,
                    'priority': ChipType.accent,
                  }).toList(),
                ),
                QuestionListView(
                  questions: technical.map((q) => {
                        'title': q.text,
                        'tags': q.tags,
                        'priority': ChipType.defaultType,
                      }).toList(),
                ),
                QuestionListView(
                  questions: behavioral.map((q) => {
                        'title': q.text,
                        'tags': q.tags,
                        'priority': ChipType.defaultType,
                      }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
