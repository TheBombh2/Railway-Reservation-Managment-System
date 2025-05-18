import 'package:dio/dio.dart';
import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/data/repositories/employee_repository.dart';
import 'package:employee_frontend/data/services/employee_service.dart';
import 'package:employee_frontend/ui/shared_features/citations/bloc/citations_bloc.dart';
import 'package:employee_frontend/ui/shared_features/citations/widgets/citations_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CitationsScreen extends StatelessWidget {
  const CitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CitationsBloc(
          employeeRepository: EmployeeRepository(
              employeeService: EmployeeService(context.read<Dio>())),
          authenticationRepository: context.read<AuthenticationRepository>())
        ..add(LoadCitations()),
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Color(0xff0076CB),
            ),
            title: Text(
              'Citations',
              style: TextStyle(
                  color: Color(0xff0076CB),
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: CitationsList()),
    );
  }
}
