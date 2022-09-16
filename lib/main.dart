import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/pages/bottom_navigation_bar.dart';
import 'package:video_player/pages/login_page.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wivivo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: backgroundColor,
            splashColor: ligthDark,
            primaryColor: primaryColor,
            textTheme: GoogleFonts.poppinsTextTheme()),
        routes: <String, WidgetBuilder>{
          '/': (context) => const LoginPage(),
          '/home': (context) => const BottomNavigation()
        });
  }
}
