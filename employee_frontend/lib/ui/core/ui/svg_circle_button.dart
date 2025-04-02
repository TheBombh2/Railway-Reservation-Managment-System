import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgCircleButton extends StatelessWidget {
  const SvgCircleButton({
    required this.labelText,
    required this.svgAsset,
    this.width = 90,
    super.key,
  });
  final String svgAsset;
  final String labelText;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xffE9F3F9),
              borderRadius: BorderRadius.circular(40)),
          height: 72,
          width: 72,
          child: Center(
            child: SvgPicture.asset(svgAsset),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
            width: width,
            height: 50,
            child: Text(
              labelText,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(fontSize: 18),
            ))
      ],
    );
  }
}
