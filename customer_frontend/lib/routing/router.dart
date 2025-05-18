import 'package:customer_frontend/data/model/user.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/ui/auth/bloc/authentication_bloc.dart';
import 'package:customer_frontend/ui/login/widgets/login_screen.dart';
import 'package:customer_frontend/ui/auth/widgets/onboarding/onboarding1.dart';
import 'package:customer_frontend/ui/auth/widgets/onboarding/onboarding2.dart';
import 'package:customer_frontend/ui/auth/widgets/register_screen.dart';
import 'package:customer_frontend/ui/auth/widgets/reset_password_screen.dart';
import 'package:customer_frontend/ui/home/widgets/home_screen.dart';
import 'package:customer_frontend/ui/profile/widgets/profile_screen.dart';
import 'package:customer_frontend/ui/reservation/stations/widgets/station_selection_screen.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/ticket_details_screen.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/ticket_reservation_screen.dart';
import 'package:customer_frontend/ui/reservation/trains/widgets/trains_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
late  User userData;

final router = GoRouter(
  initialLocation: '/login',
  redirect:(ctx, state) {
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
    GoRoute(path: '/login', builder: (ctx, state) => LoginScreen(), routes: [
      GoRoute(path: '/register',builder: (context, state) => RegisterScreen(),),
      GoRoute(path: '/reset_password',builder: (context, state) => ResetPasswordScreen(),),
      GoRoute(path: '/onboarding1',builder: (context, state) => Onboarding1(),),
      GoRoute(path: '/onboarding2',builder: (context, state) => Onboarding2(),)
    ]),
    GoRoute(
      path: '/',
      pageBuilder: (ctx, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (ctx, animation, secondartAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
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
          builder: (ctx, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: 'trains',
          builder: (ctx, state) => const TrainsScreen(),
          routes: [
            GoRoute(
              path: 'station_selection_screen',
              builder: (ctx, state) => StationSelectionScreen(),
            ),
            GoRoute(
              path: 'ticket_reserve',
              builder: (ctx, state) => const TicketReservationScreen(),
            ),
          ],
        ),

        GoRoute(
          path: 'ticket_details',
          builder: (ctx, state) => const TicketDetailsScreen(),
        ),
      ],
    ),
  ],
);
