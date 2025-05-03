import 'package:go_router/go_router.dart';
import 'package:manager_frontend/ui/auth/widgets/login_screen.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_fragment.dart';
import 'package:manager_frontend/ui/home/widgets/home_screen.dart';
import 'package:manager_frontend/ui/profile/widgets/profile_fragment.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => LoginScreen()),
    GoRoute(path: '/home',builder: (ctx,state) => HomeScreen()),
    GoRoute(path: '/profile', builder: (ctx, state) => ProfileFragment()),
    GoRoute(path: '/employees', builder: (ctx, state) => EmployeesFragment()),
  ],
);
