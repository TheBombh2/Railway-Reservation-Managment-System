import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:employee_frontend/ui/shared_features/appraisals/widgets/appraisals_screen.dart';
import 'package:employee_frontend/ui/train_driver/assigned_trains/widgets/assigned_trains_screen.dart';
import 'package:employee_frontend/ui/auth/widgets/login_screen.dart';
import 'package:employee_frontend/ui/shared_features/citations/widgets/citations_screen.dart';
import 'package:employee_frontend/ui/home/widgets/home_screen.dart';
import 'package:employee_frontend/ui/shared_features/profile/widgets/profile_screen.dart';
import 'package:employee_frontend/ui/shared_features/tasks/widgets/tasks_screen.dart';
import 'package:employee_frontend/ui/train_driver/train_tracking/widgets/train_tracking_screen.dart';
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => LoginScreen()),
    GoRoute(
        path: '/home',
        pageBuilder: (ctx, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: (ctx, animation, secondartAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(
                  curve: curve,
                ),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(path: 'profile', builder: (ctx, state) => const ProfileScreen()),
          GoRoute(path: 'tasks', builder: (ctx, state) => const TasksScreen()),
          GoRoute(path: 'appraisals', builder: (ctx, state) => const AppraisalsScreen()),
          GoRoute(path: 'citations', builder: (ctx, state) => const CitationsScreen()),
          GoRoute(path: 'assigned_trains', builder: (ctx, state) => const AssignedTrainsScreen()),
          GoRoute(path: 'train_tracking', builder: (ctx, state) => const TrainTrackingScreen()),
        ]),
  ],
);