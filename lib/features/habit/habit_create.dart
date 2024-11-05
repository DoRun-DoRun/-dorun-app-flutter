import 'package:dorun_app_flutter/common/component/custom_button.dart';
import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/component/gap_row.dart';
import 'package:dorun_app_flutter/common/component/input_box.dart';
import 'package:dorun_app_flutter/common/constant/colors.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:dorun_app_flutter/features/routine/view/components/repeat_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HabitCreateScreen extends StatefulWidget {
  static String get routeName => 'habitCreate';

  const HabitCreateScreen({super.key});

  @override
  State<HabitCreateScreen> createState() => _HabitCreateScreen();
}

class _HabitCreateScreen extends State<HabitCreateScreen> {
  final TextEditingController _textController = TextEditingController();
  String? _habitGoal;
  String? _habitCategory;

  List<String> guideQuestions = [
    '어떤 습관을 만들고 싶나요?',
    '습관에 해당하는 카테고리를 알려주세요.',
  ];

  List<String> habitOptions = [
    "건강",
    "공부",
    "외모관리",
    "마음의 안정",
    "규칙적인 삶",
    "취미활동",
    "의료",
    "기타"
  ];

  @override
  void initState() {
    super.initState();
  }

  String getCurrentGuideQuestion() {
    if (_habitGoal == null) {
      return guideQuestions[0];
    }
    return guideQuestions[1];
  }

  void _setHabitGoal(String value) {
    setState(() {
      _habitGoal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "습관 생성하기",
      backgroundColor: Colors.white,
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GapColumn(
                  gap: 16,
                  children: <Widget>[
                    Text(
                      getCurrentGuideQuestion(),
                      style: AppTextStyles.BOLD_20,
                    ),
                    if (_habitGoal != null)
                      Builder(builder: (innerContext) {
                        List<Widget> gapRows = List.generate(
                          4,
                          (rowIndex) => GapRow(
                            gap: 16,
                            children: List.generate(
                              2,
                              (colIndex) {
                                int index = rowIndex * 2 + colIndex;
                                String habit = habitOptions[index];

                                return Expanded(
                                  child: buildRepeatOptionButton(
                                    habit,
                                    _habitCategory == habit,
                                    () {
                                      setState(() {
                                        _habitCategory = habit;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                        return GapColumn(gap: 16, children: [
                          const Text(
                            "카테고리",
                            style: AppTextStyles.MEDIUM_12,
                          ),
                          ...gapRows
                        ]);
                      }),
                    InputBox(
                      controller: _textController,
                      hintText: '습관 목표',
                      onSubmitted: _setHabitGoal,
                      focused: _textController.text != '',
                    ),
                  ],
                ),
              ),
            ),
            if (_habitCategory != null)
              CustomButton(
                onPressed: () {
                  context.go(
                    '/habit_create_progress',
                    extra: CreateHabitModel(
                      habitGoal: _habitGoal!,
                      habitCategory: _habitCategory!,
                    ),
                  );
                },
                title: "완료하기",
                backgroundColor: AppColors.BRAND_SUB,
                foregroundColor: AppColors.TEXT_BRAND,
              ),
          ],
        ),
      ),
    );
  }
}
