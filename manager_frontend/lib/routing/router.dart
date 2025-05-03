import 'package:go_router/go_router.dart';
import 'package:manager_frontend/ui/auth/widgets/login_screen.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_screen.dart';
import 'package:manager_frontend/ui/profile/widgets/profile_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => LoginScreen()),
    GoRoute(path: '/profile', builder: (ctx, state) => ProfileScreen()),
    GoRoute(path: '/employees', builder: (ctx, state) => EmployeesScreen()),
  ],
);
