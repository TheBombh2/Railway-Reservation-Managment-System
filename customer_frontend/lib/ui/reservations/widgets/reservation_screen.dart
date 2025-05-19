import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/data/repositories/reservation_repository.dart';
import 'package:customer_frontend/data/services/reservation_service.dart';
import 'package:customer_frontend/ui/reservations/bloc/reservation_bloc.dart';
import 'package:customer_frontend/ui/reservations/widgets/reservation_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppraisalsScreen extends StatelessWidget {
  const AppraisalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => ReservationsBloc(
            reservationRepository: ReservationRepository(
              reservationService: ReservationService(context.read<Dio>()),
            ),
            authenticationRepository: context.read<AuthenticationRepository>(),
          )..add(LoadReservations()),

      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Color(0xff0076CB)),
          title: Text(
            'Appraisals',
            style: TextStyle(
              color: Color(0xff0076CB),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: AppraisalsList(),
      ),
    );
  }
}
