import 'package:customer_frontend/ui/reservation/tickets/widgets/class_select_button.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/trip_progress_bar.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/tickets_to_buy_counter.dart';
import 'package:flutter/material.dart';

class TicketReservationScreen extends StatefulWidget {
  const TicketReservationScreen({super.key});

  @override
  State<TicketReservationScreen> createState() =>
      _TicketReservationScreenState();
}

class _TicketReservationScreenState extends State<TicketReservationScreen> {
  String selectedClass = "1st";
  int numbOfTicketsToBuy = 1;
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
        padding: const EdgeInsets.symmetric(vertical:  64.0,horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripProgressBar(),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClassSelectButton(
                  degree: '1st',
                  iconPath: 'assets/svg/first_class.svg',
                  isSelected: selectedClass == "1st",
                  selectClass: () => _selectClass("1st"),
                ),
                ClassSelectButton(
                  degree: '2nd',
                  iconPath: 'assets/svg/second_class.svg',
                  isSelected: selectedClass == "2nd",
                  selectClass: () => _selectClass("2nd"),
                ),
                ClassSelectButton(
                  degree: '3rd',
                  iconPath: 'assets/svg/third_class.svg',
                  isSelected: selectedClass == "3rd",
                  selectClass: () => _selectClass("3rd"),
                ),
              ],
            ),

            SizedBox(height: 24),

            TicketsToBuyCounter(
              numbOfTicketsToBuy: numbOfTicketsToBuy,
              increase: () => _incremenTickets(),
              decrease: () => _decrementTickets(),
            ),
          ],
        ),
      ),
    );
  }

  void _selectClass(String degree) {
    setState(() {
      selectedClass = degree;
    });
  }

  void _incremenTickets() {
    setState(() {
      numbOfTicketsToBuy += 1;
      if (numbOfTicketsToBuy > 10) {
        numbOfTicketsToBuy = 10;
      }
    });
  }

  void _decrementTickets() {
    setState(() {
      numbOfTicketsToBuy -= 1;
      if (numbOfTicketsToBuy < 1) {
        numbOfTicketsToBuy = 1;
      }
    });
  }
}
