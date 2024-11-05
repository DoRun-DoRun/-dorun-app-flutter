import 'package:dorun_app_flutter/common/component/custom_button.dart';
import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/component/list_item.dart';
import 'package:dorun_app_flutter/common/component/padding_container.dart';
import 'package:dorun_app_flutter/common/constant/colors.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/features/search/model/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TemplateDetailScreen extends ConsumerWidget {
  static String get routeName => 'templateDetail';

  final RoutineTemplate routine;

  const TemplateDetailScreen({super.key, required this.routine});

  String getTotalDuration() {
    int totlaDuration = routine.subRoutines
        .fold(0, (sum, subRoutine) => sum + subRoutine.duration);
    return '${(totlaDuration ~/ 60).toString()}분';
  }

  @override
  Widget build(BuildContext context, ref) {
    return DefaultLayout(
      title: '템플릿 상세',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: GapColumn(
                gap: 16,
                children: [
                  PaddingContainer(
                    width: double.infinity,
                    child: GapColumn(
                      children: [
                        Text(routine.goal, style: AppTextStyles.BOLD_20),
                        const SizedBox(height: 24),
                        Text("총 소요시간",
                            style: AppTextStyles.MEDIUM_14.copyWith(
                              color: AppColors.TEXT_SUB,
                            )),
                        const SizedBox(height: 8),
                        Text(getTotalDuration(), style: AppTextStyles.BOLD_20),
                      ],
                    ),
                  ),
                  PaddingContainer(
                    child: GapColumn(
                      gap: 16,
                      children: [
                        const Text("세부 루틴", style: AppTextStyles.BOLD_20),
                        ...routine.subRoutines.map(
                          (subRoutine) => ListItem(
                            routineId: 0,
                            title: subRoutine.goal,
                            subTitle:
                                '${(subRoutine.duration ~/ 60).toString()}분',
                            routinEmoji: subRoutine.emoji,
                            actionIcon: Icons.add,
                            onTap: () {
                              context.push(
                                '/template_detail_add',
                                extra: {
                                  'routine': routine,
                                  'selectedRoutine': subRoutine,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          PaddingContainer(
              child: CustomButton(
            onPressed: () {
              context.push('/routine_create',
                  extra: RoutineCreateArgs(routineTemplate: routine));
            },
            title: "한번에 루틴 추가히기",
            backgroundColor: AppColors.BRAND,
            foregroundColor: Colors.white,
          ))
        ],
      ),
    );
  }
}
