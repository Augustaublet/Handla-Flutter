import 'package:flutter/material.dart';
import 'package:template/components/lableTextField.dart';
import 'package:template/themes.dart';
import 'package:template/components/costomButton.dart';

class LoginCard extends StatefulWidget {
  late bool register;
  LoginCard({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  @override
  void initState() {
    super.initState();
    widget.register = false;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 150, left: 8.0, right: 8.0),
      child: Container(
        width: deviceWidth * 0.85,
        height: deviceHeight * 0.65,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Themes.colors.medium.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 3,
            )
          ],
          borderRadius: BorderRadius.circular(30),
          color: Themes.colors.light,
        ),
        child: Column(
          children: [
            _headLine(),
            const Spacer(),
            _userNameField(userNameController),
            _passwordField(passwordController),
            _emailField(emailController),
            _signInOrRegister(),
            _navToSignUp(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget _headLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Text(
        widget.register ? "Register account" : "Login",
        style: Themes.textStyle.headline1,
      ),
    );
  }

  Widget _userNameField(userNameController) {
    return LabledTextField(
      lableText: "User name",
      controller: userNameController,
    );
  }

  Widget _passwordField(passwordController) {
    return LabledTextField(
      lableText: "Password",
      controller: passwordController,
    );
  }

  Widget _emailField(emailController) {
    return widget.register
        ? LabledTextField(lableText: "Email", controller: emailController)
        : Container();
  }

  Widget _signInOrRegister() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomButton(
        height: 45,
        width: 80,
        color: Themes.colors.mediumDark,
        onPressed: () {},
        text: Text(
          widget.register ? "Sign up" : "Sign in",
          style: Themes.textStyle.buttonText,
        ),
      ),
    );
  }

  Widget _navToSignUp() {
    return TextButton(
      child: Text(widget.register ? "Back to Sign in" : "Sign up"),
      onPressed: () {
        setState(
          () {
            widget.register = !widget.register;
          },
        );
      },
    );
  }
}
