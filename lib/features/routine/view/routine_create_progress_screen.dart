import 'dart:async';

import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:dorun_app_flutter/features/routine/model/routine_model.dart';
import 'package:dorun_app_flutter/features/routine/provider/routine_provider.dart';
import 'package:dorun_app_flutter/features/routine/repository/routine_repository.dart';
import 'package:dorun_app_flutter/features/search/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constant/colors.dart';

class RoutineCreateProgressScreen extends ConsumerStatefulWidget {
  static String get routeName => 'routineCreateProgress';

  final String routineGoal;
  final Duration startTime;
  final List<bool> weekDays;
  final Duration? alertTime;
  final List<SubRoutineTemplate>? subRoutines;
  final CreateHabitModel? habitModel;
  final HabitResponse? habitResponse;

  const RoutineCreateProgressScreen({
    super.key,
    required this.routineGoal,
    required this.startTime,
    required this.weekDays,
    required this.alertTime,
    this.subRoutines,
    this.habitModel,
    this.habitResponse,
  });

  @override
  ConsumerState<RoutineCreateProgressScreen> createState() =>
      _RoutineCreateProgressScreenState();
}

class _RoutineCreateProgressScreenState
    extends ConsumerState<RoutineCreateProgressScreen> {
  double progress = 0.0;
  Timer? timer;
  bool routineCreated = false;

  @override
  void initState() {
    super.initState();
    createRoutine();
    startProgress();
  }

  void startProgress() {
    timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      double stepIncrement = routineCreated ? (1.0 / 100) : (1.0 / 1000);
      setState(() {
        progress += stepIncrement;
        if (progress >= 0.9 && !routineCreated) {
          progress = 0.9;
        } else if (progress >= 1.0 && routineCreated) {
          progress = 1.0;
          timer.cancel();

          // 타이머가 완료되면 Main 화면으로 이동
          context.go('/');
        }
      });
    });
  }

  String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    const formattedTime =
        "\${timeOfDay.hour.toString().padLeft(2, '0')}:\${timeOfDay.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  Future<void> createRoutine() async {
    final routineRepository = ref.read(routineRepositoryProvider);
    print(
        "${widget.routineGoal} + ${widget.startTime.inSeconds} ${widget.weekDays} ${widget.alertTime?.inSeconds} ${widget.subRoutines} ${widget.habitModel?.habitCategory} ${widget.habitResponse}");

    try {
      await routineRepository.createRoutine(
        CreateRoutineModel(
          goal: widget.routineGoal,
          startTime: widget.startTime.inSeconds,
          repeatDays: widget.weekDays,
          notificationTime: widget.alertTime?.inSeconds,
          subRoutines: widget.subRoutines,
          habitCategory: widget.habitModel?.habitCategory,
          actions: widget.habitResponse?.actions,
        ),
        util: widget.subRoutines == null ? 'gpt' : '',
      );

      if (!mounted) return;

      routineCreated = true;
      ref.invalidate(routineListProvider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create routine: \$e')),
        );
      }
    }
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
                  '열심히 최적의\n루틴을 생성하고 있어요',
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
