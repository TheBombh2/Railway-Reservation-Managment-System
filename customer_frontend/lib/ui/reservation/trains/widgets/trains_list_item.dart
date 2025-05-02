import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrainsListItem extends StatelessWidget {
  const TrainsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset('assets/svg/train.svg'),
      contentPadding: EdgeInsets.all(10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'KTS/MDA-1122',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Aluthgama',
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.people,color: Colors.green,),
              SizedBox(width: 10,),
              Text(
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
                'Arrival Now',
              ),
            ],
          ),
        ],
      ),
      trailing: FloatingActionButton.small(
        onPressed: () {
          
          context.go('/home/trains/ticket_reserve');
          
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(Icons.arrow_forward_ios_rounded, color: Color(0xff0076CB)),
      ),
    );
  }
}
