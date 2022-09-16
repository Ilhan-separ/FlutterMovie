import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/constants.dart';
import 'package:video_player/pages/bottom_navigation_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .28,
            ),
            Text(
              'Login',
              style: heading.copyWith(fontSize: 36),
            ),
            customSizedBox(25),
            TextField(
              decoration: customInputDecoration("Kullanıcı Adı / Email"),
              style: normalText,
            ),
            customSizedBox(20),
            TextField(
              decoration: customInputDecoration("Şifre"),
              style: normalText,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
            ),
            customSizedBox(40),
            Center(
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Şifremi Unuttum",
                    style: TextStyle(color: primaryColor),
                  )),
            ),
            customSizedBox(20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Stack(children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          primaryColor,
                          Color.fromARGB(255, 235, 101, 89),
                        ]),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(42, 12, 42, 12),
                    ),
                    child: Text(
                      "Giriş Yap",
                      style: normalText.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customSizedBox(double height) => SizedBox(
        height: height,
      );

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: normalText.copyWith(color: Color.fromARGB(75, 255, 255, 255)),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: ligthDark,
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
    );
  }
}
