import 'package:flutter/material.dart';
import 'package:template/themes.dart';

class CustomButton extends StatelessWidget {
  late Widget text;
  late VoidCallback onPressed;
  late double width;
  late double height;
  late Color color;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Themes.colors.medium.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(45),
          color: color,
        ),
        child: TextButton(
          onPressed: onPressed,
          child: text,
        ),
      ),
    );
  }
}
