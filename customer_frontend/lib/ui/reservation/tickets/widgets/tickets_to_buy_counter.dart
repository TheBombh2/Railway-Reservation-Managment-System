import 'package:customer_frontend/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class TicketsToBuyCounter extends StatelessWidget {
  const TicketsToBuyCounter({
    super.key,
    required this.numbOfTicketsToBuy,
    required this.increase,
    required this.decrease,
  });
  final int numbOfTicketsToBuy;
  final void Function() increase;
  final void Function() decrease;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.remove,color: AppColors.mainColor,), onPressed: decrease),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(numbOfTicketsToBuy.toString()),
                  SizedBox(width: 4),
                  Icon(Icons.confirmation_number,color: AppColors.mainColor, size: 20),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.add,color: AppColors.mainColor,), onPressed: increase),
          ],
        ),
    
        SizedBox(height: 16),
    
        // Price
        Center(
          child: Text(
            '\$29.99',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
    
        SizedBox(height: 24),
    
        // Buy Tickets button
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              backgroundColor: Color(0xff0076CB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: Text(
              'Buy Tickets',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
