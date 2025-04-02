import 'package:employee_frontend/ui/auth/widgets/login_screen.dart';
import 'package:employee_frontend/ui/home/widgets/home_screen.dart';
import 'package:employee_frontend/ui/profile/widgets/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
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
        GoRoute(path: 'profile',builder: (ctx,state)=>const ProfileScreen()),
      ]
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'RRMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
