import 'package:flutter/material.dart';
import 'package:video_player/pages/favorites_page.dart';
import 'package:video_player/pages/home_page.dart';
import 'package:video_player/pages/search_page.dart';
import '../constants.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    buildCurrentPage(int i) {
      switch (i) {
        case 0:
          return const HomePage();
        case 1:
          return SearchPage();
        case 2:
          return const FavoritesPage();
        default:
          return Container();
      }
    }

    return Scaffold(
      body: buildCurrentPage(currentIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: backgroundColor,
          splashColor: primaryAccent,
          highlightColor: primaryAccent.withOpacity(.3),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          unselectedItemColor: Color.fromARGB(255, 95, 95, 95),
          selectedItemColor: primaryColor,
          elevation: 4,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ara"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Fav"),
          ],
        ),
      ),
    );
  }
}
