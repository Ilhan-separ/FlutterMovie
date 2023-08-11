import 'package:flutter/material.dart';
import 'package:video_player/constants.dart';
import 'package:video_player/pages/result_page.dart';
import 'package:video_player/pages/search_result_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final genreList = [
    'Action',
    'Comedy',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Drama',
    'Crime',
    'Animation',
    'Adventure',
    'Fantasy',
    'Mystery',
    'Thriller'
  ];

  final colorList = [
    Color(0xFF087CFA),
    Color.fromARGB(255, 202, 200, 42),
    Color.fromARGB(255, 255, 47, 234),
    Color(0xFFDD1265),
    Color(0xFF07C3F2),
    Color(0xFF3DEA62),
    Color(0xFFFE2857),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Theme(
        data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(accentColor: primaryAccent)),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 12.0, right: 12.0, top: 2, bottom: 2),
              child: TextField(
                autofocus: false,
                style: normalText,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                  focusColor: primaryColor,
                  hintText: "Search movies etc.",
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  hintStyle: TextStyle(
                      letterSpacing: .0, color: Colors.white.withOpacity(.3)),
                  fillColor: Colors.white.withOpacity(.1),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                        color: ligthDark,
                        width: .2,
                      )),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ligthDark,
                        width: .2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ligthDark,
                        width: .2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
                onSubmitted: (text) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchResultPage(
                      submitted: text,
                    );
                  }));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 4.0, bottom: 6.0),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 28 / 18),
                children: [
                  for (var i = 0; i < 12; i++)
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GenreTile(
                        genre: genreList[i],
                        index: i,
                        containerColor: colorList[(i * 3) % colorList.length],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class GenreTile extends StatelessWidget {
  final String genre;
  final int index;
  final Color containerColor;
  const GenreTile(
      {Key? key,
      required this.genre,
      required this.index,
      required this.containerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ResultPage(genre: genre);
          }));
          print("Pressed ${genre} at index ${index}");
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: containerColor.withOpacity(0.8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                genre,
                style: normalText.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
