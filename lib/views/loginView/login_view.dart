import 'package:flutter/material.dart';
import 'package:template/themes.dart';
import 'package:template/views/loginView/loginCard.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.colors.mediumLight,
      body: Center(
        child: Column(
          children: [
            // picture logo
            LoginCard(),
          ],
        ),
      ),
    );
  }
}
