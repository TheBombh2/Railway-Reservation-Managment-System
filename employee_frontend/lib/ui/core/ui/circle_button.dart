import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.labelText,
    required this.asset,
    this.width = 90,
    this.isSVG = true,
    super.key,
  });
  final String asset;
  final String labelText;
  final double width;
  final bool isSVG;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffE9F3F9),
                borderRadius: BorderRadius.circular(40)),
            height: 72,
            width: 72,
            child: Center(
              child: isSVG? SvgPicture.asset(asset) : Image.asset(asset,color: Color(0xff0076CB),),
            ),
          ),
          SizedBox(height: 8,),
          SizedBox(
              width: width,
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }
}
