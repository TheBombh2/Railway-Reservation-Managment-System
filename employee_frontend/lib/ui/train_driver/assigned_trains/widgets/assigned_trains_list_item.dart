import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AssignedTrainsListItem extends StatelessWidget {
  const AssignedTrainsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: SvgPicture.asset('assets/svg/train.svg'),
        contentPadding: EdgeInsets.all(10),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              'KTS/MDA-1122',
            ),
            Text(
              style:
                  TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),
              'Aluthgama',
            ),
            Text(
              style:
                  TextStyle(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.6)),
              '8:00 PM',
            ),
          ],
        ),
        trailing: FloatingActionButton.small(
          onPressed: () {
            context.push('/home/train_tracking');
            debugPrint("new screen?");
          },
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(
              0xff0076CB,
            ),
          ),
        ));
  }
}
