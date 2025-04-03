import 'package:employee_frontend/ui/core/ui/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> buttons = [
      {
        'label': 'Assigned Trains',
        'icon': 'assets/svg/map_train_station.svg',
        'isSVG': true,
        'onTap': () {
          debugPrint("Train screen");
        }
      },
      {
        'label': 'Profile',
        'icon': 'assets/svg/profile.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/home/profile');
        }
      },
      {
        'label': 'Tasks',
        'icon': 'assets/svg/tasks.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/home/tasks');
        }
      },
      {
        'label': 'Appraisals',
        'icon': 'assets/images/star.png',
        'isSVG': false,
        'onTap': () {
          context.push('/home/appraisals');
        }
      },
      {
        'label': 'Citations',
        'icon': 'assets/images/warning.png',
        'isSVG': false,
        'onTap': () {
          context.push('/home/citations');
        }
      },
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
                    Rect.fromLTRB(0, 300, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/home_screen.png',
                  height: 450,
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
            height: 70,
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
                padding: EdgeInsets.all(16),
                itemCount: allowedButtons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      allowedButtons.length <= 4 ? allowedButtons.length : 4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (ctx, index) {
                  return CircleButton(
                    labelText: allowedButtons[index]['label']!,
                    asset: allowedButtons[index]['icon']!,
                    isSVG: allowedButtons[index]['isSVG'],
                    onTap: allowedButtons[index]['onTap'],
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
      'Citations'
    ];
    return allowed.contains(label);
  }
}
