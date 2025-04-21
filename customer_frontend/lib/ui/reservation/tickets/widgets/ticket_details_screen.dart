import 'package:customer_frontend/ui/reservation/tickets/widgets/trip_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xff0076CB)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KTS/MDA-1122',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              'Colombo Fort - Aluthgama',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.6),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '448-82-204567',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TripProgressBar(),

                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date:',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    ),
                    Text(
                      '12th June 2025',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Passenger:',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    ),
                    Text(
                      'ELGamed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Id:',
                      style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                    ),
                    Text(
                      '448-82-204567',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                Divider(),
                Center(child: Image.asset('assets/images/bar_code.png')),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.download_rounded, color: Color(0xff0076CB),),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.info_outline_rounded,color: Color(0xff0076CB)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
