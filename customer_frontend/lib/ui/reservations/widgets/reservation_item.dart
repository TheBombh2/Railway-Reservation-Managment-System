import 'package:customer_frontend/data/model/reservation.dart';
import 'package:customer_frontend/ui/reservations/widgets/reservation_item_details.dart';
import 'package:flutter/material.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({
    required this.reservation,
    super.key,
  });

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          useSafeArea: true,
          enableDrag: true,
          builder: (ctx) {
            return ReservationItemDetails(reservation:reservation);
          }),
      splashColor: Color(0xffF3F5FF),
      hoverColor: Color(0xffF3F5FF),
      focusColor: Color(0xffF3F5FF),
      contentPadding: EdgeInsets.all(20),
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xffE9F3F9), borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Icon(
            Icons.directions_train_outlined,
            color: Color(0xff0077CD),
            size: 46,
          ),
        ),
      ),
      title: Text(
        reservation.trainName!,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.7)),
      ),
    );
  }
}
