import 'package:employee_frontend/data/model/user.dart';
import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/ui/auth/bloc/authentication_bloc.dart';
import 'package:employee_frontend/ui/conductor/verfity_tickets/widgets/qr_scanner_screen.dart';
import 'package:employee_frontend/ui/conductor/verfity_tickets/widgets/verfiy_ticket_screen.dart';
import 'package:employee_frontend/ui/maintenance/maintenance_jobs/widgets/maintenance_jobs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:employee_frontend/ui/shared_features/appraisals/widgets/appraisals_screen.dart';
import 'package:employee_frontend/ui/train_driver/assigned_trains/widgets/assigned_trains_screen.dart';
import 'package:employee_frontend/ui/login/widgets/login_screen.dart';
import 'package:employee_frontend/ui/shared_features/citations/widgets/citations_screen.dart';
import 'package:employee_frontend/ui/home/widgets/home_screen.dart';
import 'package:employee_frontend/ui/shared_features/profile/widgets/profile_screen.dart';
import 'package:employee_frontend/ui/shared_features/tasks/widgets/tasks_screen.dart';
import 'package:employee_frontend/ui/train_driver/train_tracking/widgets/train_tracking_screen.dart';

late  User userData;
final router = GoRouter(
  initialLocation: '/login',
  redirect: (ctx, state) {
    final authenticationBloc = ctx.read<AuthenticationBloc>();
    final authStatus = authenticationBloc.state.status;

    final isAuthenticated = authStatus == AuthenticationStatus.authenticated;
    final isUnAuthenticated =
        authStatus == AuthenticationStatus.unauthenticated;

    final loggingIn = state.matchedLocation == '/login';

    if (isUnAuthenticated && !loggingIn) {
      return '/login';
    } else if (isAuthenticated && loggingIn) {
      userData = authenticationBloc.state.user;
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (ctx, state) => LoginScreen()),
    GoRoute(
        path: '/',
        pageBuilder: (ctx, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child:  HomeScreen(user:userData),
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
          GoRoute(
              path: 'profile',
              builder: (ctx, state) =>
                  ProfileScreen(userData: state.extra as User)),
          GoRoute(path: 'tasks', builder: (ctx, state) => const TasksScreen()),
          GoRoute(
              path: 'appraisals',
              builder: (ctx, state) => const AppraisalsScreen()),
          GoRoute(
              path: 'citations',
              builder: (ctx, state) => const CitationsScreen()),
          GoRoute(
              path: 'assigned_trains',
              builder: (ctx, state) => const AssignedTrainsScreen()),
          GoRoute(
              path: 'train_tracking',
              builder: (ctx, state) => const TrainTrackingScreen()),
          GoRoute(
              path: 'maintenance_jobs',
              builder: (ctx, state) => const MaintenanceJobsScreen()),
          GoRoute(
              path: 'verify_ticket',
              builder: (ctx, state) => const VerfiyTicketScreen(),
              routes: [
                GoRoute(
                    path: 'qr_scanner',
                    builder: (ctx, state) => const QRScannerScreen())
              ]),
        ]),
  ],
);
