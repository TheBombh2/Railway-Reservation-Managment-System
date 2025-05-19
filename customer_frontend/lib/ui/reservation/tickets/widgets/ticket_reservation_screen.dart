import 'package:customer_frontend/data/model/station.dart';
import 'package:customer_frontend/data/model/ticket.dart';
import 'package:customer_frontend/data/model/train.dart';
import 'package:customer_frontend/data/repositories/authentication_repository.dart';
import 'package:customer_frontend/data/repositories/reservation_repository.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/class_select_button.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/trip_progress_bar.dart';
import 'package:customer_frontend/ui/reservation/tickets/widgets/tickets_to_buy_counter.dart';
import 'package:customer_frontend/ui/reservation/trains/bloc/trains_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TicketReservationScreen extends StatefulWidget {
  final List data;
  const TicketReservationScreen(this.data, {super.key});

  @override
  State<TicketReservationScreen> createState() =>
      _TicketReservationScreenState();
}

class _TicketReservationScreenState extends State<TicketReservationScreen> {
  String selectedClass = "1st";
  String seatPrice = "29.99";
  int numbOfTicketsToBuy = 1;

  @override
  Widget build(BuildContext context) {
    Train train = widget.data[0];
    Station firstStation = widget.data[1];
    Station secondStation = widget.data[2];
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xff0076CB)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${firstStation.name} => ${secondStation.name}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripProgressBar(train, firstStation.name!, secondStation.name!),

            SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClassSelectButton(
                  degree: '1st',
                  iconPath: 'assets/svg/first_class.svg',
                  isSelected: selectedClass == "1st",
                  selectClass: () => _selectClass("1st", "29.99"),
                ),
                ClassSelectButton(
                  degree: '2nd',
                  iconPath: 'assets/svg/second_class.svg',
                  isSelected: selectedClass == "2nd",
                  selectClass: () => _selectClass("2nd", "39.99"),
                ),
                ClassSelectButton(
                  degree: '3rd',
                  iconPath: 'assets/svg/third_class.svg',
                  isSelected: selectedClass == "3rd",
                  selectClass: () => _selectClass("3rd", "49.99"),
                ),
              ],
            ),

            SizedBox(height: 24),

            /*TicketsToBuyCounter(
              numbOfTicketsToBuy: numbOfTicketsToBuy,
              increase: () => _incremenTickets(),
              decrease: () => _decrementTickets(),
            ),
            */
            Center(
              child: Text(
                '\$$seatPrice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            BlocConsumer<TrainsBloc, TrainsState>(
              listener: (context, state) {
                if (state is TrainsError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is StationOperationSuccess) {
                  context.go('/');
                }
              },
              builder: (context, state) {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      backgroundColor: Color(0xff0076CB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      final data = Ticket(
                        destinationArrivalDate: train.destinationArrivalTime,
                        ticketsNum: 1,
                        ticketsType:
                            selectedClass == "1st"
                                ? 1
                                : selectedClass == "2nd"
                                ? 2
                                : 3,
                        trainArrivalDate: train.trainArrivalTime,
                        trainID: train.trainID,
                      );
                      context.read<TrainsBloc>().add(ReserveTicket(data));
                    },
                    child: Text(
                      'Buy Ticket',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _selectClass(String degree, String price) {
    setState(() {
      selectedClass = degree;
      seatPrice = price;
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
