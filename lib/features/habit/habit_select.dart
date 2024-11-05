import 'package:dorun_app_flutter/common/component/custom_button.dart';
import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/constant/colors.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:dorun_app_flutter/features/routine/view/components/repeat_button.dart';
import 'package:dorun_app_flutter/features/search/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HabitSelectScreen extends StatefulWidget {
  static String get routeName => 'habitSelect';
  final HabitResponse habitResponse;
  final CreateHabitModel habit;

  const HabitSelectScreen(
      {super.key, required this.habitResponse, required this.habit});

  @override
  State<HabitSelectScreen> createState() => _HabitSelectScreen();
}

class _HabitSelectScreen extends State<HabitSelectScreen> {
  final List<String> _habitCategories = [];

  @override
  void initState() {
    super.initState();
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
                    const Text(
                      "습관을 만들기 위해 선호하는 활동을 선택해주세요.",
                      style: AppTextStyles.BOLD_20,
                    ),
                    Builder(builder: (innerContext) {
                      List<Widget> gapRows = List.generate(
                        widget.habitResponse.actions.length,
                        (index) {
                          String habit = widget.habitResponse.actions[index];
                          bool isSelected = _habitCategories.contains(habit);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: buildRepeatOptionButton(
                              habit,
                              isSelected,
                              () {
                                setState(() {
                                  if (isSelected) {
                                    _habitCategories.remove(habit);
                                  } else {
                                    if (_habitCategories.length < 8) {
                                      _habitCategories.add(habit);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('카테고리는 최대 8개까지 선택할 수 있습니다.'),
                                        ),
                                      );
                                    }
                                  }
                                });
                              },
                            ),
                          );
                        },
                      );

                      return GapColumn(
                        gap: 8,
                        children: [
                          const Text(
                            "최대 8개까지 선택 할 수 있어요.",
                            style: AppTextStyles.MEDIUM_12,
                          ),
                          ...gapRows,
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                context.go(
                  '/routine_create',
                  extra: RoutineCreateArgs(
                    habitResponse: HabitResponse(actions: _habitCategories),
                    habit: widget.habit,
                  ),
                );
              },
              title: "완료하기",
              backgroundColor: AppColors.TEXT_BRAND,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
