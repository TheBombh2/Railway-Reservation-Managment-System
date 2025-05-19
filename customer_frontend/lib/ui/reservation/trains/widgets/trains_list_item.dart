import 'package:customer_frontend/data/model/station.dart';
import 'package:customer_frontend/data/model/train.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrainsListItem extends StatelessWidget {
  final Station firstStation;
  final Station secondStation;
  final Train train;
  const TrainsListItem(this.train,this.firstStation,this.secondStation, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset('assets/svg/train.svg'),
      contentPadding: EdgeInsets.all(10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: Colors.green),
              SizedBox(width: 10),
              Text(
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
                'Arrival: ${train.trainArrivalTime}',
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.people, color: Colors.red),
              SizedBox(width: 10),
              Text(
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
                'Destination: ${train.trainArrivalTime}',
              ),
            ],
          ),
        ],
      ),
      trailing: IconButton.outlined(
        icon: Icon(Icons.arrow_right_alt_outlined),
        onPressed: () {
          context.go('/trains/ticket_reserve',extra: [train,firstStation,secondStation]);
        },
      ),
    );
  }
}
