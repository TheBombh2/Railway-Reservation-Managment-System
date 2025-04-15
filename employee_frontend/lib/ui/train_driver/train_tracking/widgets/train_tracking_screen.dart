import 'package:employee_frontend/ui/train_driver/assigned_trains/widgets/from_to_information_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrainTrackingScreen extends StatelessWidget {
  const TrainTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Color(0xff0076CB),
          ),
          title: Text(
            'Tracking Train',
            style: TextStyle(
                color: Color(0xff0076CB),
                fontSize: 22,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              spacing: 100,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/svg/train-journey.svg', height: 172),
                FromToInformationBox(fromCity: 'fromCity', toCity: 'toCity'),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF0076CB),
                        padding: EdgeInsetsDirectional.symmetric(
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      'Start Tracking',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
