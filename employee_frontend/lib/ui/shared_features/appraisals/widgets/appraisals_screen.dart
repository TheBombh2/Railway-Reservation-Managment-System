import 'package:dio/dio.dart';
import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/data/repositories/employee_repository.dart';
import 'package:employee_frontend/data/services/employee_service.dart';import 'package:employee_frontend/ui/shared_features/appraisals/bloc/appraisals_bloc.dart';
import 'package:employee_frontend/ui/shared_features/appraisals/widgets/appraisals_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppraisalsScreen extends StatelessWidget {
  const AppraisalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppraisalsBloc(
          employeeRepository: EmployeeRepository(
              employeeService: EmployeeService(context.read<Dio>())),
          authenticationRepository: context.read<AuthenticationRepository>())..add(LoadAppraisals()),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Color(0xff0076CB),
          ),
          title: Text(
            'Appraisals',
            style: TextStyle(
                color: Color(0xff0076CB),
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: AppraisalsList(),
      ),
    );
  }
}
