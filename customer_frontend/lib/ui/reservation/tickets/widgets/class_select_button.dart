import 'package:customer_frontend/ui/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClassSelectButton extends StatelessWidget {
  const ClassSelectButton({
    required this.degree,
    required this.iconPath,
    required this.isSelected,
    super.key,
    required this.selectClass,
  });
  final String degree;
  final String iconPath;
  final bool isSelected;
  final void Function() selectClass;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectClass,
      child: Container(
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 6,
                    ),
                  ]
                  : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              isSelected
                                  ? Colors.white
                                  : Colors.black.withValues(alpha: 0.3),
                        ),
                        children: [
                          TextSpan(text: degree[0]),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.top,
                            child: Transform.translate(
                              offset: Offset(0, 0),
                              child: Text(
                                degree.substring(1),
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.black.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Class',
                      style: TextStyle(
                        color:
                            isSelected
                                ? Colors.white
                                : Colors.black.withValues(alpha: 0.3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? Colors.white
                      : Colors.black.withValues(alpha: 0.3),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
