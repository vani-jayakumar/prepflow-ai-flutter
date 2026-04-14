import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/question_list_view.dart';
import '../../../../shared/widgets/app_chip.dart';

class QuestionBankScreen extends StatefulWidget {
  const QuestionBankScreen({super.key});

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _technicalQuestions = [
    {
      'title': 'How do you approach scaling a monolithic application?',
      'tags': ['Architecture'],
      'priority': ChipType.accent,
    },
    {
      'title': 'Explain the difference between SQL and NoSQL databases.',
      'tags': ['Database', 'Backend'],
      'priority': ChipType.defaultType,
    },
  ];

  final List<Map<String, dynamic>> _behavioralQuestions = [
    {
      'title': 'Tell me about a time you had a conflict with a team member.',
      'tags': ['Soft Skills', 'Leadership'],
      'priority': ChipType.accent,
    },
    {
      'title': 'Describe a situation where you had to meet a tight deadline.',
      'tags': ['Efficiency'],
      'priority': ChipType.defaultType,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: isDarkMode ? 0.4 : 0.8),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: isDarkMode
                      ? Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.5)
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
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(context).disabledColor,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: const [
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
                QuestionListView(questions: _technicalQuestions),
                QuestionListView(questions: _behavioralQuestions),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
