import 'package:employee_frontend/data/repositories/authentication_repository.dart';
import 'package:employee_frontend/ui/core/shared_widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context)  {
    List<Map<String, dynamic>> buttons = [
      /*{
        'label': 'Assigned Trains',
        'icon': 'assets/svg/map_train_station.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/home/assigned_trains');
        }
      },
      */
      {
        'label': 'Profile',
        'icon': 'assets/svg/profile.svg',
        'isSVG': true,
        'onTap': () async {
          context.push('/profile',extra: await context.read<AuthenticationRepository>().getUser());
        }
      },
      {
        'label': 'Tasks',
        'icon': 'assets/svg/tasks.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/tasks');
        }
      },
      {
        'label': 'Appraisals',
        'icon': 'assets/images/star.png',
        'isSVG': false,
        'onTap': () {
          context.push('/appraisals');
        }
      },
      {
        'label': 'Citations',
        'icon': 'assets/images/warning.png',
        'isSVG': false,
        'onTap': () {
          context.push('/citations');
        }
      },
      /*
      {
        'label': 'Maintenance Jobs',
        'icon': 'assets/svg/tools.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/home/maintenance_jobs');
        },
        'fontSize': 11.4,
      },
      {
        'label': 'Verify Ticket',
        'icon': 'assets/svg/ticket.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/home/verify_ticket');
        },
        
        
      },

      */
      // More buttons can be added dynamically
    ];

    // Simulate filtering buttons based on permissions
    List<Map<String, dynamic>> allowedButtons =
        buttons.where((button) => checkPermission(button['label']!)).toList();

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(
                    Rect.fromLTRB(0, 250, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/home_screen.png',
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                top: 124,
                left: 28,
                width: 200,
                child: Text(
                  maxLines: 2,
                  'Good Morning! ELGamed',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black.withValues(
                        alpha: 0.6,
                      ),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        color: const Color.fromARGB(123, 158, 158, 158),
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                        blurStyle: BlurStyle.outer)
                  ]),
              child: GridView.builder(
                padding: EdgeInsets.all(15),
                itemCount: allowedButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      allowedButtons.length <= 4 ? allowedButtons.length : 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (ctx, index) {
                  return CircleButton(
                    labelText: allowedButtons[index]['label']!,
                    asset: allowedButtons[index]['icon']!,
                    isSVG: allowedButtons[index]['isSVG'],
                    onTap: allowedButtons[index]['onTap'],
                    fontSize: allowedButtons[index]['fontSize'] ?? 14.0,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  bool checkPermission(String label) {
    // Simulated permission checking
    List<String> allowed = [
      'Assigned Trains',
      'Profile',
      'Tasks',
      'Appraisals',
      'Citations',
      'Maintenance Jobs',
      'Verify Ticket',
    ];
    return allowed.contains(label);
  }
}
