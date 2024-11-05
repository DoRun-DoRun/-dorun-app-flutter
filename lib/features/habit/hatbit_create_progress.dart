import 'dart:async';

import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:dorun_app_flutter/features/habit/repository/habit_repository.dart';
import 'package:dorun_app_flutter/features/search/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constant/colors.dart';

class HabitCreateProgressScreen extends ConsumerStatefulWidget {
  static String get routeName => 'habitCreateProgress';

  final String habitGoal;
  final String habitCategory;

  const HabitCreateProgressScreen({
    super.key,
    required this.habitGoal,
    required this.habitCategory,
  });

  @override
  ConsumerState<HabitCreateProgressScreen> createState() =>
      _HabitCreateProgressScreenState();
}

class _HabitCreateProgressScreenState
    extends ConsumerState<HabitCreateProgressScreen> {
  double progress = 0.0;
  Timer? timer;
  bool routineCreated = false;
  late HabitResponse habitList;

  @override
  void initState() {
    super.initState();
    createHabitList();
    startProgress();
  }

  void startProgress() {
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      double stepIncrement = routineCreated ? (1.0 / 100) : (1.0 / 1000);
      setState(
        () {
          progress += stepIncrement;
          if (progress >= 0.9 && !routineCreated) {
            progress = 0.9;
          } else if (progress >= 1.0 && routineCreated) {
            progress = 1.0;
            timer.cancel();

            context.go(
              '/habit_select',
              extra: RoutineCreateArgs(
                habit: CreateHabitModel(
                  habitGoal: widget.habitGoal,
                  habitCategory: widget.habitCategory,
                ),
                habitResponse: habitList,
              ),
            );
          }
        },
      );
    });
  }

  Future<void> createHabitList() async {
    final habitRepository = ref.read(habitRepositoryProvider);

    try {
      habitList = await habitRepository.createHabit(
        CreateHabitModel(
          habitGoal: widget.habitGoal,
          habitCategory: widget.habitCategory,
        ),
      );

      if (!mounted) return;

      routineCreated = true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create routine: \$e')),
        );
      }
    }
  }

  String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    const formattedTime =
        "\${timeOfDay.hour.toString().padLeft(2, '0')}:\${timeOfDay.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GapColumn(
              gap: 72,
              children: [
                const Text(
                  '사용자님에게 맞는\n여러 행동들을 찾아보고 있어요',
                  style: AppTextStyles.BOLD_20,
                ),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.BACKGROUND_SUB,
                  valueColor:
                      const AlwaysStoppedAnimation<Color?>(AppColors.BRAND),
                  minHeight: 5,
                ),
                Center(
                  child: Image.asset(
                    'asset/images/working.gif',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
