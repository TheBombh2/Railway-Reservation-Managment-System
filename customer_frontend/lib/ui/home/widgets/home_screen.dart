import 'package:customer_frontend/ui/core/shared_widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> buttons = [
      {
        'label': 'Trains',
        'icon': 'assets/svg/map_train_station.svg',
        'isSVG': true,
        'onTap': () {
          context.push('/home/trains');
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
      
    ];

    
    
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
                  'Good Morning!',
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
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      buttons.length <= 4 ? buttons.length : 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (ctx, index) {
                  return CircleButton(
                    labelText: buttons[index]['label']!,
                    asset: buttons[index]['icon']!,
                    isSVG: buttons[index]['isSVG'],
                    onTap: buttons[index]['onTap'],
                    fontSize: buttons[index]['fontSize'] ?? 14.0,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  
}
