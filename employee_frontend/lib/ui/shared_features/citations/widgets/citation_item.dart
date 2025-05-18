import 'package:employee_frontend/data/model/citation.dart';
import 'package:employee_frontend/ui/shared_features/citations/widgets/citation_item_details.dart';
import 'package:flutter/material.dart';

class CitationItem extends StatelessWidget {
  const CitationItem({
    required this.citation,
    super.key,
  });

  final Citation citation;

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
            return CitationItemDetails(citation:citation);
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
            Icons.warning_amber_rounded,
            color: Color(0xff0077CD),
            size: 46,
          ),
        ),
      ),
      title: Text(
        citation.title!,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.7)),
      ),
    );
  }
}
