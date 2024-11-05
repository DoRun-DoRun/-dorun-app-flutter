import 'package:dorun_app_flutter/features/habit/habit_create.dart';
import 'package:dorun_app_flutter/features/habit/habit_select.dart';
import 'package:dorun_app_flutter/features/habit/hatbit_create_progress.dart';
import 'package:dorun_app_flutter/features/habit/model/habit_model.dart';
import 'package:dorun_app_flutter/features/routine/model/routine_model.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_create_progress_screen.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_create_screen.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_detail_screen.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_edit_screen.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_proceed_screen.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_review_edit_screen.dart';
import 'package:dorun_app_flutter/features/routine/view/routine_review_screen.dart';
import 'package:dorun_app_flutter/features/search/model/search_model.dart';
import 'package:dorun_app_flutter/features/search/view/template_detail_add_screen.dart';
import 'package:dorun_app_flutter/features/search/view/template_detail_screen.dart';
import 'package:dorun_app_flutter/features/user/provider/user_me_provider.dart';
import 'package:dorun_app_flutter/features/user/view/onboarding_screen.dart';
import 'package:dorun_app_flutter/features/user/view/user_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common/view/root_tab.dart';
import '../../../common/view/splash_screen.dart';
import '../model/user_model.dart';
import '../view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
        ),
        GoRoute(
          path: '/habit_create',
          name: HabitCreateScreen.routeName,
          builder: (_, __) => const HabitCreateScreen(),
        ),
        GoRoute(
          path: '/habit_create_progress',
          name: HabitCreateProgressScreen.routeName,
          builder: (context, state) {
            final args = state.extra as CreateHabitModel;

            return HabitCreateProgressScreen(
              habitGoal: args.habitGoal,
              habitCategory: args.habitCategory,
            );
          },
        ),
        GoRoute(
          path: '/habit_select',
          name: HabitSelectScreen.routeName,
          builder: (context, state) {
            final args = state.extra as RoutineCreateArgs;

            return HabitSelectScreen(
              habit: args.habit!,
              habitResponse: args.habitResponse!,
            );
          },
        ),
        GoRoute(
          path: '/routine_create',
          name: RoutineCreateScreen.routeName,
          builder: (context, state) {
            RoutineCreateArgs? args;

            args = state.extra as RoutineCreateArgs?;
            return RoutineCreateScreen(
              routine: args?.routineTemplate,
              habit: args?.habit,
              habitResponse: args?.habitResponse,
            );
          },
        ),
        GoRoute(
          path: '/routine_create_progress',
          name: RoutineCreateProgressScreen.routeName,
          builder: (context, state) {
            final args = state.extra as RoutineCreateProgressArgs;

            return RoutineCreateProgressScreen(
              routineGoal: args.routineGoal,
              startTime: args.startTime,
              weekDays: args.weekDays,
              alertTime: args.alertTime,
              subRoutines: args.subRoutines,
              habitModel: args.habitModel,
              habitResponse: args.habitResponse,
            );
          },
        ),
        GoRoute(
          path: '/routine_proceed/:id',
          name: RoutineProceedScreen.routeName,
          builder: (context, state) => RoutineProceedScreen(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/routine_review_edit/:id',
          name: RoutineReviewEditScreen.routeName,
          builder: (context, state) => RoutineReviewEditScreen(
            id: int.parse(state.pathParameters['id']!),
            routineHistory: state.extra as RoutineHistory,
          ),
        ),
        GoRoute(
          path: '/routine_edit',
          name: RoutineEditScreen.routeName,
          builder: (context, state) => RoutineEditScreen(
            routine: state.extra as DetailRoutineModel,
          ),
        ),
        GoRoute(
          path: '/routine_review/:id',
          name: RoutineReviewScreen.routeName,
          builder: (context, state) => RoutineReviewScreen(
            id: int.parse(state.pathParameters['id']!),
            routineHistory: state.extra as RoutineHistory,
          ),
        ),
        GoRoute(
          path: '/routine_detail/:id',
          name: RoutineDetailScreen.routeName,
          builder: (context, state) => RoutineDetailScreen(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
        GoRoute(
          path: '/template_detail',
          name: TemplateDetailScreen.routeName,
          builder: (context, state) {
            final routine = state.extra as RoutineTemplate;
            return TemplateDetailScreen(
              routine: routine,
            );
          },
        ),
        GoRoute(
          path: '/template_detail_add',
          name: TemplateDetailAddScreen.routeName,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return TemplateDetailAddScreen(
              routine: args['routine']! as RoutineTemplate,
              selectedRoutine: args['selectedRoutine']! as SubRoutineTemplate,
            );
          },
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/onBoarding',
          name: OnboardingScreen.routeName,
          builder: (_, __) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/userInfo',
          name: UserInfoScreen.routeName,
          builder: (_, __) => const UserInfoScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  void signOut() {
    ref.read(userMeProvider.notifier).signOut();
  }

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final logginIn = state.matchedLocation == '/login';

    if (user == null) {
      print('User is Null');
      return logginIn ? null : '/login';
    }

    if (user is UserModel && user.memberStatus == 'Register') {
      print(user.memberStatus);
      return logginIn || state.matchedLocation == '/splash'
          ? '/onBoarding'
          : null;
    }

    if (user is UserModel) {
      return logginIn || state.matchedLocation == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    return null;
  }
}
