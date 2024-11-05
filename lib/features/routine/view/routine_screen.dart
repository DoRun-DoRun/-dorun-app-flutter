import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/component/gap_row.dart';
import 'package:dorun_app_flutter/common/component/list_item.dart';
import 'package:dorun_app_flutter/common/component/padding_container.dart';
import 'package:dorun_app_flutter/common/constant/colors.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/constant/spacing.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/common/utils/format.dart';
import 'package:dorun_app_flutter/common/utils/notification.dart';
import 'package:dorun_app_flutter/features/routine/provider/routine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

String getNextDay(List<bool> repeatDays) {
  int today = DateTime.now().weekday % 7;

  if (!repeatDays.contains(true)) {
    return "반복 일자 없음";
  }

  for (int i = 0; i < 7; i++) {
    int nextDay = (today + i) % 7;
    if (repeatDays[nextDay]) {
      String nextDayName = DateFormat('EEEE', 'ko_KR')
          .format(DateTime.now().add(Duration(days: i)));
      return "$nextDayName 시작";
    }
  }

  return "반복 안함";
}

class RoutineScreen extends ConsumerWidget {
  static String get routeName => 'routine';

  const RoutineScreen({super.key});

  Future<void> _refreshRoutines(WidgetRef ref) async {
    ref.invalidate(routineListProvider);

    await ref.read(routineListProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineListAsyncValue = ref.watch(routineListProvider);

    return routineListAsyncValue.when(
      data: (routines) {
        for (var routine in routines) {
          if (routine.isToday &&
              !routine.isFinished &&
              routine.notificationTime != null) {
            scheduleRoutineNotification(
              routine.id,
              '루틴 알림: ${routine.name}',
              '루틴이 곧 시작해요~! 오늘도 화이팅해봐요!',
              routine.startTime,
              routine.notificationTime!,
            );
          }
        }

        final completedCount =
            routines.where((routine) => routine.isFinished).length;
        final totalCount = routines.where((routine) => routine.isToday).length;
        final double progress =
            totalCount > 0 ? completedCount / totalCount : 0.0;

        return DefaultLayout(
          // rightIcon: IconButton(
          //   icon: const Icon(
          //     Icons.notifications,
          //     size: 30,
          //     color: AppColors.TEXT_SUB,
          //   ),
          //   onPressed: () {},
          // ),
          floatingActionButton: FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.BRAND,
            shape: const CircleBorder(),
            onPressed: () {
              context.push('/habit_create');
            },
            child: const Icon(Icons.add),
          ),
          child: GapColumn(
            gap: 16,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 24, bottom: 24, right: 24),
                  child: GapColumn(
                    gap: 16,
                    children: [
                      const DateSelector(),
                      const SizedBox(height: 8),
                      const Text('오늘의 루틴입니다', style: AppTextStyles.BOLD_20),
                      const Text('이제 시작이네요!', style: AppTextStyles.MEDIUM_14),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[300],
                        minHeight: 8,
                        borderRadius: AppRadius.ROUNDED_8,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: AppColors.BRAND,
                  onRefresh: () => _refreshRoutines(ref),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      routines.isEmpty
                          ? PaddingContainer(
                              child: GestureDetector(
                                onTap: () {
                                  context.push('/habit_create');
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: Text("루틴을 생성해주세요",
                                        style: AppTextStyles.MEDIUM_14),
                                  ),
                                ),
                              ),
                            )
                          : PaddingContainer(
                              child: GapColumn(
                                gap: AppSpacing.SPACE_16,
                                children: routines.map((routine) {
                                  return ListItem(
                                    routineId: routine.id,
                                    title: routine.name,
                                    subTitle: routine.isFinished
                                        ? "완료됨"
                                        : routine.isToday
                                            ? formatDateTime(
                                                Duration(
                                                  seconds: routine.startTime,
                                                ),
                                              )
                                            : getNextDay(routine.repeatDays),
                                    isButton:
                                        !routine.isFinished && routine.isToday,
                                    isDone:
                                        routine.isFinished || !routine.isToday,
                                    onTap: () {
                                      context.push(
                                          '/routine_detail/${routine.id}');
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('Failed to load routines $error'),
        ),
      ),
    );
  }
}

class DateSelector extends StatelessWidget {
  String getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('M월 dd일');
    return formatter.format(now);
  }

  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.5),
      child: GapRow(
        gap: 8,
        children: [
          Text(getFormattedDate(), style: AppTextStyles.MEDIUM_20),
        ],
      ),
    );
  }
}
