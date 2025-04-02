import 'package:employee_frontend/ui/core/ui/svg_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
                height: 450,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurStyle: BlurStyle.outer,
                        blurRadius: 4,
                        color: Colors.grey,
                        offset: Offset(0, 1)),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgCircleButton(
                            labelText: 'Assigned Trains',
                            svgAsset: 'assets/svg/map_train_station.svg',
                          ),
                          SvgCircleButton(
                            labelText: 'Profile',
                            svgAsset: 'assets/svg/profile.svg',
                          ),
                          SvgCircleButton(
                            labelText: 'Tasks',
                            svgAsset: 'assets/svg/tasks.svg',
                          ),
                          SvgCircleButton(
                            labelText: 'Appraisals',
                            svgAsset: 'assets/svg/star.svg',
                          ),
                        ],
                      ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgCircleButton(
                            labelText: 'Citations',
                            svgAsset: 'assets/svg/warning.svg',
                          ),
                        
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
