import 'package:employee_frontend/data/model/appraisal.dart';
import 'package:employee_frontend/ui/shared_features/appraisals/widgets/appraisal_item_details.dart';
import 'package:flutter/material.dart';

class AppraisalItem extends StatelessWidget {
  const AppraisalItem({
    required this.appraisal,
    super.key,
  });

  final Appraisal appraisal;

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
            return AppraisalItemDetails(appraisal:appraisal);
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
            Icons.star_outline_rounded,
            color: Color(0xff0077CD),
            size: 46,
          ),
        ),
      ),
      title: Text(
        appraisal.title!,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.7)),
      ),
    );
  }
}
