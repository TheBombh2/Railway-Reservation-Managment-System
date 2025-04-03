import 'package:employee_frontend/ui/core/ui/mission_item_details.dart';
import 'package:flutter/material.dart';

enum MissionType { task, citation, appraisal }

class MissionItem extends StatelessWidget {
  const MissionItem({
    required this.type,
    required this.content,
    required this.title,
    this.amount,
    super.key,
  });

  final MissionType type;
  final String content;
  final String title;
  final double? amount;
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
            return MissionItemDetails(
              type: type,
              title: title,
              amount: amount,
            );
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
            type == MissionType.task
                ? Icons.task_outlined
                : type == MissionType.appraisal
                    ? Icons.star_outline_rounded
                    : Icons.warning_amber_rounded,
            color: Color(0xff0077CD),
            size: 46,
          ),
        ),
      ),
      title: Text(
        content,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.7)),
      ),
      trailing: Text(
        'Now',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.4)),
      ),
    );
  }
}
