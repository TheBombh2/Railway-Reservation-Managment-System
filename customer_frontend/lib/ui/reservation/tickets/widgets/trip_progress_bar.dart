import 'package:customer_frontend/data/model/train.dart';
import 'package:flutter/material.dart';

class TripProgressBar extends StatelessWidget {
  Train train;
  String firstStation;
  String secondStation;
  TripProgressBar(
    this.train,
    this.firstStation,
    this.secondStation, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                train.trainArrivalTime!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                firstStation,
                style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(color: Colors.grey.shade300, thickness: 5),
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue, size: 30),
                      Spacer(),
                      Icon(Icons.location_on, color: Colors.blue, size: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                train.destinationArrivalTime!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                secondStation,
                style: TextStyle(color: Colors.black.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
