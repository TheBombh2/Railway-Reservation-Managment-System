import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_frontend/data/model/manager.dart';
import 'package:manager_frontend/ui/auth/bloc/authentication_bloc.dart';
import 'package:manager_frontend/ui/departments/widgets/departments_fragment.dart';
import 'package:manager_frontend/ui/home/bloc/home_bloc.dart';
import 'package:manager_frontend/ui/home/widgets/admin_navigation_drawer.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/employees/widgets/employees_fragment.dart';
import 'package:manager_frontend/ui/profile/widgets/profile_fragment.dart';
import 'package:manager_frontend/ui/routes/widgets/routes_fragment.dart';
import 'package:manager_frontend/ui/stations/widgets/stations_fragment.dart';
import 'package:manager_frontend/ui/trains/widgets/trains_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryWhite,
      body: Row(
        children: [
          AdminNavigationDrawer(),
          Expanded(
            child: Column(
              children: [
                // Header section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: darkBlue),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 0, 26.6),
                    child: Text(
                      "Welcome, ${context.select((AuthenticationBloc bloc)=> bloc.state.manager.basicInfo?.firstName ?? 'User')}!",
                      style: TextStyle(color: primaryWhite, fontSize: 32),
                    ),
                  ),
                ),
                // Scrollable content section
                //EmployeesScreen()
                //ProfileFragment()
                BlocBuilder<HomeBloc,HomeState>(builder: (context,state){
                  switch(state.currentFragment){
                    case FragmentType.profileFragment:
                    return ProfileFragment(manager: context.select((AuthenticationBloc bloc)=> bloc.state.manager));
                    default :
                    return Placeholder();
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
