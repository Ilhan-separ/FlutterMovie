import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:video_player/constants.dart';
import 'package:video_player/widgets/movies_genre_list.dart';

import '../model/movie_card_model.dart';
import '../pages/movie_page.dart';

class FilmTile extends StatefulWidget {
  final String title;
  final String summary;
  final int id;
  final String posterURL;
  final Movie? movieData;
  final List<dynamic>? genres;

  const FilmTile(
      {required this.posterURL,
      required this.title,
      Key? key,
      required this.summary,
      required this.id,
      this.movieData,
      required this.genres})
      : super(key: key);

  @override
  State<FilmTile> createState() => _FilmTileState();
}

class _FilmTileState extends State<FilmTile> {
  @override
  Widget build(BuildContext context) {
    var _containerHeight = MediaQuery.of(context).size.height * .28;
    var width = MediaQuery.of(context).size.width;
    int? genreLenght = widget.movieData!.movie![widget.id]["genres"].length;
    late bool genreNull;
    if (genreLenght == null) {
      genreNull = true;
    } else {
      genreNull = false;
    }
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkResponse(
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: backgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 25, 25, 25),
                  offset: Offset(-1, 1),
                  blurRadius: 0.8,
                  spreadRadius: 0.4,
                ),
                BoxShadow(
                  color: Color.fromARGB(255, 35, 35, 35),
                  offset: Offset(1, -1),
                  blurRadius: 0.5,
                  spreadRadius: 0.1,
                ),
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.posterURL,
                  width: width * .35,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: _containerHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.genres!.length,
                          itemBuilder: (context, index) {
                            return InkResponse(
                              child: HorizontalGenreList(
                                genres: widget.movieData!.movie![widget.id]
                                    ["genres"],
                                index: index,
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                      Text(
                        widget.summary,
                        style: normalText.copyWith(
                            fontSize: 12, color: Colors.white.withOpacity(.7)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                      ),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 4.0)),
                          Text(
                            widget.movieData!.movie![widget.id]['year']
                                .toString(),
                            style: normalText.copyWith(
                                fontSize: 10,
                                color: Colors.white.withOpacity(.6)),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            Icons.star,
                            size: 10,
                            color: Colors.yellow.withOpacity(.8),
                          ),
                          const SizedBox(
                            width: 1.0,
                          ),
                          Text(
                            widget.movieData!.movie![widget.id]['rating']
                                .toString(),
                            style: normalText.copyWith(
                                fontSize: 10,
                                color: Colors.white.withOpacity(.6)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MoviePage(
              movieData: widget.movieData,
              title: widget.title,
              summary: widget.summary,
              id: widget.id,
            );
          }));
        },
      ),
    );
  }
}
