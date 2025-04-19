import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.labelText,
    required this.asset,
    this.width = 69,
    this.isSVG = true,
    this.fontSize = 14,
    required this.onTap,
    super.key,
  });
  final String asset;
  final String labelText;
  final double width;
  final bool isSVG;
  final double fontSize;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xffE9F3F9),
                borderRadius: BorderRadius.circular(40)),
            height: 64,
            width: 64,
            child: Center(
              child: isSVG
                  ? SvgPicture.asset(
                      asset,
                      width: 40,
                      colorFilter: ColorFilter.mode(
                        Color(0xff0076CB),
                        BlendMode.srcIn,
                      ),
                    )
                  : Image.asset(
                      asset,
                      color: Color(0xff0076CB),
                      width: 40,
                    ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
              width: width,
              child: Text(
                labelText,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(fontSize: fontSize),
              ))
        ],
      ),
    );
  }
}
