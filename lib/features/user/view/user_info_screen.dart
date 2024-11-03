import 'package:dorun_app_flutter/common/component/custom_bottom_sheet.dart';
import 'package:dorun_app_flutter/common/component/custom_button.dart';
import 'package:dorun_app_flutter/common/component/gap_column.dart';
import 'package:dorun_app_flutter/common/component/gap_row.dart';
import 'package:dorun_app_flutter/common/component/input_box.dart';
import 'package:dorun_app_flutter/common/constant/colors.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/common/layout/default_layout.dart';
import 'package:dorun_app_flutter/features/routine/view/components/repeat_button.dart';
import 'package:dorun_app_flutter/features/user/provider/user_me_provider.dart';
import 'package:dorun_app_flutter/features/user/repository/user_repository.dart';
import 'package:dorun_app_flutter/features/user/view/components/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static String get routeName => 'userInfo';

  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  bool isFinished = false;

  final TextEditingController _nameController = TextEditingController();
  String? _selectedName;
  String? _selectedAge;
  String? _selectedGender;
  String? _selectedJob;
  List<String> guideQuestions = [
    '그전에 혹시\n사용자님을 어떻게 부르면 될까요?',
    '님을 보다 잘 이해하기 위해서 나이 정보가 필요해요.',
    '성별은 어떻게 되나요?',
    '하시는 일이 무엇인가요?',
  ];

  List<String> jobOptions = ["학생", "직장인", "프리랜서", "자영업자", "취준생", "기타"];
  List<String> genderOptions = ["남성", "여성"];

  String getCurrentGuideQuestion() {
    if (_selectedName == null) {
      return guideQuestions[0];
    } else if (_selectedAge == null) {
      if (_selectedName != '') return _selectedName! + guideQuestions[1];
      return '사용자${guideQuestions[1]}';
    } else if (_selectedGender == null) {
      return guideQuestions[2];
    } else {
      return guideQuestions[3];
    }
  }

  void _setUserName(String value) {
    setState(() {
      _selectedName = value;
    });
    if (_selectedAge == null) {
      showYearPicker(context, (value) {
        setState(() {
          _selectedAge = (DateTime.now().year - value).toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRepository = ref.watch(userRepositoryProvider);

    return DefaultLayout(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: isFinished
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 32,
                      ),
                      child: const Stack(
                        alignment: Alignment.center,
                        children: [
                          ChatBubble(
                              text: "좋아요~! 거의 다 왔어요.\n이제 저와 함께 습관을 만들러 가봐요"),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'asset/images/congrate.gif',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    height: 103,
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    child: GapRow(
                      gap: 16,
                      children: [
                        Expanded(
                          child: CustomButton(
                            backgroundColor: AppColors.BRAND_SUB,
                            foregroundColor: AppColors.BRAND,
                            title: '나중에 할게요',
                            onPressed: () async {
                              await userRepository.updateUser(
                                name: _selectedName,
                                age: _selectedAge,
                                job: _selectedJob,
                                gender: _selectedGender,
                                memberStatus: 'Onboarding',
                              );
                              if (context.mounted) context.go('/');
                              ref.invalidate(userMeProvider);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            backgroundColor: AppColors.BRAND,
                            foregroundColor: Colors.white,
                            title: '좋아요',
                            onPressed: () async {
                              await userRepository.updateUser(
                                name: _selectedName,
                                age: _selectedAge,
                                job: _selectedJob,
                                gender: _selectedGender,
                                memberStatus: 'Onboarding',
                              );
                              if (context.mounted) {
                                context.go('/');
                                context.push('/routine_create');
                              }
                              ref.invalidate(userMeProvider);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: GapColumn(
                        gap: 16,
                        children: [
                          Text(
                            getCurrentGuideQuestion(),
                            style: AppTextStyles.BOLD_20,
                          ),
                          if (_selectedName != null &&
                              _selectedAge != null &&
                              _selectedGender != null)
                            Builder(builder: (innerContext) {
                              List<Widget> gapRows = List.generate(
                                3,
                                (rowIndex) => GapRow(
                                  gap: 16,
                                  children: List.generate(
                                    2,
                                    (colIndex) {
                                      int index = rowIndex * 2 + colIndex;
                                      String job = jobOptions[index];

                                      return Expanded(
                                        child: buildRepeatOptionButton(
                                          job,
                                          _selectedJob == job,
                                          () {
                                            setState(() {
                                              _selectedJob = job;
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
                                  "직업",
                                  style: AppTextStyles.MEDIUM_12,
                                ),
                                ...gapRows
                              ]);
                            }),
                          if (_selectedName != null && _selectedAge != null)
                            Builder(
                              builder: (innerContext) {
                                return GapColumn(
                                  gap: 16,
                                  children: [
                                    const Text("성별",
                                        style: AppTextStyles.MEDIUM_12),
                                    GapRow(
                                      gap: 16,
                                      children: [
                                        Expanded(
                                          child: buildRepeatOptionButton(
                                              genderOptions[0],
                                              _selectedGender ==
                                                  genderOptions[0], () {
                                            setState(() {
                                              _selectedGender =
                                                  genderOptions[0];
                                            });
                                          }),
                                        ),
                                        Expanded(
                                          child: buildRepeatOptionButton(
                                              genderOptions[1],
                                              _selectedGender ==
                                                  genderOptions[1], () {
                                            setState(() {
                                              _selectedGender =
                                                  genderOptions[1];
                                            });
                                          }),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          if (_selectedName != null)
                            Builder(builder: (innerContext) {
                              return ReadOnlyBox(
                                hintText: "나이",
                                inputText:
                                    _selectedAge != null && _selectedAge != ''
                                        ? '$_selectedAge살'
                                        : '',
                                onTap: () {
                                  showYearPicker(
                                    innerContext,
                                    (value) {
                                      setState(() {
                                        _selectedAge =
                                            (DateTime.now().year - value)
                                                .toString();
                                      });
                                    },
                                  );
                                },
                              );
                            }),
                          InputBox(
                            controller: _nameController,
                            hintText: '이름',
                            onSubmitted: _setUserName,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_selectedAge != null &&
                      _selectedGender != null &&
                      _selectedName != null &&
                      _selectedJob != null)
                    CustomButton(
                      backgroundColor: AppColors.BRAND,
                      foregroundColor: Colors.white,
                      title: "완료하기",
                      onPressed: () async {
                        setState(() {
                          isFinished = true;
                        });
                      },
                    ),
                  if (_selectedAge == null)
                    Builder(builder: (innerContext) {
                      return CustomButton(
                        title: "나중에 입력할래요",
                        onPressed: () {
                          setState(() {
                            _selectedName ??= '';

                            if (_selectedAge == null) {
                              showYearPicker(context, (value) {
                                setState(() {
                                  _selectedAge =
                                      (DateTime.now().year - value).toString();
                                });
                              });
                            }
                          });
                        },
                      );
                    }),
                ],
              ),
      ),
    );
  }
}
