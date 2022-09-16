import 'package:flutter/material.dart';
import 'package:video_player/constants.dart';

class HorizontalGenreList extends StatelessWidget {
  final List<dynamic> genres;
  final int index;
  const HorizontalGenreList(
      {Key? key, required this.genres, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: genres.isEmpty
          ? Container()
          : Container(
              padding: EdgeInsets.only(left: 6.0, right: 6.0),
              decoration: BoxDecoration(
                border: Border.all(color: ligthDark, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  genres[index],
                  style: normalText.copyWith(fontSize: 11),
                ),
              )),
    );
  }
}
