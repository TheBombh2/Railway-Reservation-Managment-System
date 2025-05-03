import 'package:go_router/go_router.dart';
import 'package:manager_frontend/ui/auth/widgets/login_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => LoginScreen()),
  ],
);
