import 'package:flutter/material.dart';

class TripProgressBar extends StatelessWidget {
  const TripProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '7:05 PM',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Rathmalana',
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
                '7:45 PM',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                'Panadura',
                style: TextStyle(color: Colors.black.withValues(alpha:  0.6)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
