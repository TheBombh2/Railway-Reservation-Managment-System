import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_frontend/data/repositories/authentication_repositroy.dart';
import 'package:manager_frontend/ui/auth/bloc/authentication_bloc.dart';
import 'package:manager_frontend/ui/login/widgets/login_screen.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_fragment.dart';
import 'package:manager_frontend/ui/home/widgets/home_screen.dart';
import 'package:manager_frontend/ui/profile/widgets/profile_fragment.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (ctx, state) {
    final authenticationBloc = ctx.read<AuthenticationBloc>();
    final authStatus = authenticationBloc.state.status;

    final isAuthenticated = authStatus == AuthenticationStatus.authenticated;
    final isUnAuthenticated =
        authStatus == AuthenticationStatus.unauthenticated;

      if(isUnAuthenticated && !state.matchedLocation.contains('/login')){
        return '/login';
      }
      else if(isAuthenticated){
        return '/';
      }
      return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (ctx, state) => LoginScreen()),
    GoRoute(path: '/', builder: (ctx, state) => HomeScreen()),
    GoRoute(path: '/profile', builder: (ctx, state) => ProfileFragment()),
    GoRoute(path: '/employees', builder: (ctx, state) => EmployeesFragment()),
  ],
);
