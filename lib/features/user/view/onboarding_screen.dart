import 'package:dorun_app_flutter/common/constant/colors.dart';
import 'package:dorun_app_flutter/common/constant/fonts.dart';
import 'package:dorun_app_flutter/features/user/view/components/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  static String get routeName => 'onboarding';
  final int? id;

  const OnboardingScreen({super.key, this.id});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  late int _currentIndex;
  bool _isLoading = false;

  final List<String> messages = [
    "안녕하세요!\n저와 대화하려면 저를 클릭해주세요!",
    "반가워요!\n저는 사용자의 삶을 설계해주는 라이프 디자이너, 라디에요!",
    "살아가면서 한가지 목표를 이룰 수 있으면 무엇을 하고 싶나요?",
    "저와 함께 사용자님이 진짜 원하는 것을 찾아서 이를 습관으로 만들어봐요!"
  ];

  int _loadingIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.id ?? 0;
    _startLoading();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(const AssetImage('asset/images/hello.gif'), context);
    precacheImage(const AssetImage('asset/images/congrate.gif'), context);
    precacheImage(const AssetImage('asset/images/working.gif'), context);
  }

  void _startLoading() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _loadingIndex = i + 1;
        });
      });
    }

    await Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _nextMessage() async {
    if (_currentIndex < messages.length - 1) {
      // if (_currentIndex == 2) {
      //   if (!mounted) return;
      //   setState(() {
      //     _currentIndex++;
      //     _startLoading();
      //   });

      //   await Future.delayed(const Duration(milliseconds: 2000), () {
      //     if (!mounted) return;
      //     setState(() {
      //       _isQuestion = true;
      //     });
      //   });
      //   return;
      // }

      if (!mounted) return;
      setState(() {
        _currentIndex++;
        _startLoading();
      });
    } else {
      context.go('/userInfo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: _isLoading ? null : _nextMessage,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 32,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (_currentIndex < messages.length)
                            ChatBubble(
                              text: _isLoading ? '' : messages[_currentIndex],
                              isLoading: _isLoading,
                              loadingDots: _loadingIndex,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: (_currentIndex <= 1)
                        ? Image.asset(
                            'asset/images/hello.gif',
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.7,
                          )
                        : Image.asset(
                            'asset/images/working.gif',
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 32,
                    vertical: 40,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      context.go('/userInfo');
                    },
                    child: Text(
                      '건너뛰기',
                      textAlign: TextAlign.end,
                      style: AppTextStyles.MEDIUM_16.copyWith(
                        color: AppColors.TEXT_SECONDARY,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
