import 'package:customer_frontend/data/model/reservation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReservationItemDetails extends StatelessWidget {
  const ReservationItemDetails({
    required this.reservation,
    super.key,
  });

  final Reservation reservation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
        child: SingleChildScrollView(
          child: Column(
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reservation.trainName!,
                style: TextStyle(fontSize: 22),
              ),
              Text(
                'Seat Number: ${reservation.seatID!}',
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  fontSize: 18,
                ),
                //kihhuuhjuhjhijh
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Arrival Time: ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: reservation.trainArrivalTime,
                    style: TextStyle(color: Colors.green),
                  ),
                ], style: TextStyle(fontSize: 18)),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Destination Time: ',
                      style: TextStyle(
                        fontSize: 14,
                        
                      ),
                    ),
                    TextSpan(
                      text: '${reservation.destinationArrivalTime}',
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
                style: TextStyle(fontSize: 18),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}
