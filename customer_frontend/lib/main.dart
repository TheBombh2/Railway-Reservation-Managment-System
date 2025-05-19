import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/data/repositories/reservation_repository.dart';
import 'package:customer_frontend/data/services/authentication_service.dart';
import 'package:customer_frontend/data/services/customer_service.dart';
import 'package:customer_frontend/data/services/reservation_service.dart';
import 'package:customer_frontend/routing/router.dart';
import 'package:customer_frontend/secrets.dart';
import 'package:customer_frontend/ui/auth/bloc/authentication_bloc.dart';
import 'package:customer_frontend/ui/reservation/trains/bloc/trains_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create:
              (context) => Dio(
                BaseOptions(
                  connectTimeout: Duration(seconds: 30),
                  sendTimeout: Duration(seconds: 30),
                  receiveTimeout: (Duration(seconds: 30)),
                ),
              ),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationService(context.read<Dio>()),
        ),
        RepositoryProvider(
          create: (context) => CustomerService(context.read<Dio>()),
        ),
        RepositoryProvider(
          create:
              (context) => AuthenticationRepository(
                authenticationService: context.read<AuthenticationService>(),
                customerService: context.read<CustomerService>(),
              ),
          dispose: (repository) => repository.dispose(),
        ),
        
      ],
      child: BlocProvider(
        lazy: false,
        create:
            (context) => AuthenticationBloc(
              authenticationRepositroy:
                  context.read<AuthenticationRepository>(),
            )..add(AuthenticationSubscriptionRequest()),
        child: BlocProvider(
          create:
              (context) => TrainsBloc(
                reservationRepository: ReservationRepository(
                  reservationService: ReservationService(context.read<Dio>()),
                ),
                authenticationRepository:
                    context.read<AuthenticationRepository>(),
              ),

          child: AppView(),
        ),
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
