import 'package:flutter/material.dart';
import 'package:template/themes.dart';

class LabledTextField extends StatelessWidget {
  late TextEditingController controller;

  late String lableText = "";
  LabledTextField(
      {super.key, required this.lableText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20.0, right: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Themes.colors.medium.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
            )
          ],
          border: Border.all(
            color: Themes.colors.medium,
          ),
          borderRadius: BorderRadius.circular(45),
        ),
        child: TextField(
          onSubmitted: (value) {},
          decoration: InputDecoration(
            labelStyle: Themes.textStyle.headline2,
            labelText: lableText,
            contentPadding: EdgeInsets.only(top: 3, bottom: 3, left: 20),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
