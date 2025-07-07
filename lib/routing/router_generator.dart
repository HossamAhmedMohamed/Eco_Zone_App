import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/cache/cache_helper.dart';
import 'package:untitled/features/eco_zone/data/data_source/remote_data_source.dart';
import 'package:untitled/features/eco_zone/data/repo/repo.dart';
import 'package:untitled/features/eco_zone/presentation/cubit/logics_cubit.dart';
import 'package:untitled/features/eco_zone/presentation/screens/bilogical_system_page.dart';
import 'package:untitled/features/eco_zone/presentation/screens/bot_screen.dart';
import 'package:untitled/features/eco_zone/presentation/screens/dash_board.dart';
import 'package:untitled/features/eco_zone/presentation/screens/device_page.dart';
import 'package:untitled/features/eco_zone/presentation/screens/environment_sensor.dart';
import 'package:untitled/features/eco_zone/presentation/screens/login_screen.dart';
import 'package:untitled/features/eco_zone/presentation/screens/sign_up_screen.dart';

import 'package:untitled/features/eco_zone/presentation/screens/water_quality_page.dart';
import 'package:untitled/routing/app_router.dart';

class RouterGenerator {
  static final String? isAuthenticated = CacheHelper().getData(key: 'userId');
  static GoRouter mainRouting = GoRouter(
    initialLocation:
        isAuthenticated != null ? AppRouter.dashboard : AppRouter.login,
    // initialLocation: AppRouter.chat,
    errorBuilder: (context, state) {
      return const Scaffold(body: Center(child: Text('Error')));
    },
    redirect: (BuildContext context, GoRouterState state) {
      final isLogin = state.matchedLocation == AppRouter.login;
      final isSignup = state.matchedLocation == AppRouter.signup;
      final isAuthenticated = CacheHelper().getData(key: 'userId') != null;

      if (isAuthenticated && (isLogin || isSignup)) {
        return AppRouter.dashboard;
      }
      if (!isAuthenticated && !isLogin && !isSignup) {
        return AppRouter.login;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: AppRouter.signup,
        path: AppRouter.signup,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => LogicsCubit(
                    repo: Repo(remoteDataSource: RemoteDataSource()),
                  ),
              child: const SignUpScreen(),
            ),
      ),

      GoRoute(
        name: AppRouter.login,
        path: AppRouter.login,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => LogicsCubit(
                    repo: Repo(remoteDataSource: RemoteDataSource()),
                  ),
              child: const LoginScreen(),
            ),
      ),

      GoRoute(
        name: AppRouter.devices,
        path: AppRouter.devices,
        builder: (context, state) => const DevicesPage(),
      ),

      GoRoute(
        name: AppRouter.waterQuality,
        path: AppRouter.waterQuality,
        builder: (context, state) => WaterQualityScreen(),
      ),

      GoRoute(
        name: AppRouter.environment,
        path: AppRouter.environment,
        builder: (context, state) => EnvironmentSensorsScreen(),
      ),

      GoRoute(
        name: AppRouter.biologicalSystem,
        path: AppRouter.biologicalSystem,
        builder: (context, state) => const BiologicalSystemPage(),
      ),

      GoRoute(
        name: AppRouter.dashboard,
        path: AppRouter.dashboard,
        builder: (context, state) => DashboardPage(),
      ),

      GoRoute(
        name: AppRouter.chat,
        path: AppRouter.chat,
        builder: (context, state) => BotScreen(),
      ),
    ],
  );
}
