import 'package:customer_frontend/ui/auth/widgets/login_screen.dart';
import 'package:customer_frontend/ui/home/widgets/home_screen.dart';
import 'package:customer_frontend/ui/profile/widgets/profile_screen.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/ticket_details_screen.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/ticket_reservation_screen.dart';
import 'package:customer_frontend/ui/reservation/trains/widgets/trains_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          GoRoute(path: 'trains', builder: (ctx, state) => const TrainsScreen()),
          GoRoute(path: 'ticket_reserve', builder: (ctx, state) => const TicketReservationScreen()),
          GoRoute(path: 'ticket_details',builder: (ctx,state)=> const TicketDetailsScreen()),
        ]),
  ],
);