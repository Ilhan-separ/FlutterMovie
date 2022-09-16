import 'package:flutter/material.dart';
import 'package:video_player/constants.dart';
import 'package:video_player/pages/login_page.dart';
import 'package:video_player/widgets/better_video.dart';
import 'package:video_player/widgets/film_list_tile.dart';
import '../widgets/fav_button.dart';
import '../model/movie_card_model.dart';

class MoviePage extends StatefulWidget {
  final String title;
  final String summary;
  final int id;
  final Movie? movieData;

  const MoviePage(
      {required this.title,
      required this.summary,
      required this.id,
      required this.movieData,
      Key? key})
      : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 2,
        title: Text(
          widget.title,
          style: movieHeadText,
        ),
      ),
      body: Container(
        child: CustomScrollView(shrinkWrap: true, slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(children: [
                BetterVideo(
                    placeHolder: widget.movieData!.movie![widget.id]
                        ["large_cover_image"]),
                SizedBox(
                  height: 12,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: heading.copyWith(fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(left: 4.0)),
                                    Text(
                                      widget
                                          .movieData!.movie![widget.id]['year']
                                          .toString(),
                                      style: normalText.copyWith(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 11,
                                      color: Colors.yellow.withOpacity(.8),
                                    ),
                                    const SizedBox(
                                      width: 1.0,
                                    ),
                                    Text(
                                      widget.movieData!
                                          .movie![widget.id]['rating']
                                          .toString(),
                                      style: normalText.copyWith(fontSize: 12),
                                    )
                                  ],
                                )
                              ]),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const FavButton(),
                      ],
                    )),
                const Divider(
                  color: ligthDark,
                  thickness: 1,
                ),
                FilmTile(
                  posterURL: widget.movieData!.movie![widget.id]
                      ["large_cover_image"],
                  title: widget.title,
                  summary: widget.summary,
                  id: widget.id,
                  movieData: widget.movieData,
                  genres: widget.movieData!.movie![widget.id]['genres'],
                ),
                const Divider(
                  color: ligthDark,
                  thickness: 1,
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                color: ligthDark,
                elevation: 1,
                child: ListTile(
                  leading: Image.network(
                    widget.movieData!.movie![widget.id]["medium_cover_image"],
                  ),
                  title: Text(
                    "Bölüm ${index + 1}",
                    style: normalText,
                  ),
                  subtitle: Text(
                    "Bölüm adı",
                    style: normalText,
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.play_arrow,
                    color: primaryColor,
                  ),
                ),
              );
            }, childCount: 7),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              List genreFailSafe;
              if (widget.movieData!.movie![index]['genres'] == null) {
                genreFailSafe = [""];
              } else {
                genreFailSafe = widget.movieData!.movie![index]['genres'];
              }

              return FilmTile(
                posterURL: widget.movieData!.movie![index]["large_cover_image"],
                title: widget.movieData!.movie![index]['title'],
                summary: widget.movieData!.movie![index]['summary'],
                id: index,
                movieData: widget.movieData,
                genres: genreFailSafe,
              );
            }, childCount: widget.movieData!.movie!.length),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToLoginPage();
        },
        splashColor: primaryColor,
        backgroundColor: primaryColor,
        child: Icon(
          Icons.person_outline,
          color: backgroundColor,
        ),
      ),
    );
  }

  goToLoginPage() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }
}
