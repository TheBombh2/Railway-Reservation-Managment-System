import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/repositories/authentication_repositroy.dart';
import 'package:manager_frontend/data/services/authentication_service.dart';
import 'package:manager_frontend/data/services/employee_service.dart';
import 'package:manager_frontend/routing/router.dart';
import 'package:manager_frontend/ui/auth/bloc/authentication_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => Dio()),
        RepositoryProvider(
          create: (context) => AuthenticationService(context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) => EmployeeService(context.read<Dio>()),
        ),
        RepositoryProvider(
          create:
              (context) => AuthenticationRepositroy(
                authenticationService: context.read<AuthenticationService>(),
                employeeService: context.read<EmployeeService>(),
              ),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create:
            (context) => AuthenticationBloc(
              authenticationRepositroy:
                  context.read<AuthenticationRepositroy>(),
            )..add(AuthenticationSubscriptionRequest()),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        router.refresh();
      },
      child: MaterialApp.router(
        routerConfig: router,
        title: 'RRMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
