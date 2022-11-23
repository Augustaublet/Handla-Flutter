import 'package:flutter/material.dart';
import 'package:template/components/lableTextField.dart';
import 'package:template/themes.dart';
import 'package:template/components/costomButton.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import 'package:template/views/main_view.dart';

class LoginCard extends StatefulWidget {
  LoginCard({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final secretsStorage = const FlutterSecureStorage();
  late bool register;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    register = false;
    _readFromStorage();
  }

  @override
  Widget build(BuildContext context) {
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
        register ? "Register account" : "Login",
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
    return register
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
        onPressed: () async {
          if (register) {
          } else {
            // Saves login credentials to device.
            await secretsStorage.write(
                key: "KEY_USERNAME", value: userNameController.text);
            await secretsStorage.write(
                key: "KEY_PASSWORD", value: passwordController.text);
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => MainViwe()));
        },
        text: Text(
          register ? "Sign up" : "Sign in",
          style: Themes.textStyle.buttonText,
        ),
      ),
    );
  }

  Widget _navToSignUp() {
    return TextButton(
      child: Text(register ? "Back to Sign in" : "Sign up"),
      onPressed: () {
        setState(
          () {
            register = register;
          },
        );
      },
    );
  }

  Future<void> _readFromStorage() async {
    userNameController.text =
        await secretsStorage.read(key: "KEY_USERNAME") ?? '';
    passwordController.text =
        await secretsStorage.read(key: "KEY_PASSWORD") ?? '';
  }
}
