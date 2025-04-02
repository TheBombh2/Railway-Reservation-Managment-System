import 'package:flutter/material.dart';

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
                  Rect.fromLTRB(0, 250, rect.width,rect.height),
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
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.outer,
                      blurRadius: 4,
                      color: Colors.grey,
                      offset: Offset(0, 1)),
                ], borderRadius: BorderRadius.circular(10)),
                child: Text('data'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
