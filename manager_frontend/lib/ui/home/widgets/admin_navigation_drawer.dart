import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:manager_frontend/data/repositories/authentication_repositroy.dart';
import 'package:manager_frontend/ui/auth/bloc/authentication_bloc.dart';
import 'package:manager_frontend/ui/core/shared_widgets/navigation_item.dart';
import 'package:manager_frontend/ui/core/themes/theme.dart';
import 'package:manager_frontend/ui/home/bloc/home_bloc.dart';

class AdminNavigationDrawer extends StatelessWidget {
  const AdminNavigationDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: darkBlue,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: darkerBlue),
            child: Column(
              children: [
                Image.asset('assets/images/splash.png', width: 100),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Railway Managment System',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
          _buildNavigationItem(
            context,
            'Profile',
            FragmentType.profileFragment,
          ),
          _buildNavigationItem(
            context,
            'Employees Managment',
            FragmentType.employeesFragment,
          ),
          _buildNavigationItem(
            context,
            'Departments Managment',
            FragmentType.departmentsFragment,
          ),
          _buildNavigationItem(
            context,
            'Stations Managment',
            FragmentType.stationsFragment,
          ),
          _buildNavigationItem(
            context,
            'Routes Managment',
            FragmentType.routesFragment,
          ),
          _buildNavigationItem(
            context,
            'Trains Managment',
            FragmentType.trainsFragment,
          ),

          NavigationItem(
            title: 'Log out',
            onTap: () {
              context.read<AuthenticationBloc>().add(AuthenticationLogoutPressed());
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildNavigationItem(
  BuildContext context,
  String label,
  FragmentType fragmentType,
) {
  return BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      return NavigationItem(
        title: label,
        onTap: () {
          context.read<HomeBloc>().add(SwitchFragment(fragmentType));
        },
      );
    },
  );
}
