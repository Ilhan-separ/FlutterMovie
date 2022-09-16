import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/constants.dart';
import 'package:video_player/pages/movie_page.dart';
import 'package:video_player/widgets/circular_progres.dart';
import '../model/movie_card_model.dart';
import 'package:http/http.dart' as http;
import '../data/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpService httpService = HttpService();
  final postURL = "https://yts.mx/api/v2/list_movies.json?limit=20";
  late Future<Movie> futureAlbum;
  var etc = 0;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    futureAlbum = httpService.getMovie(postURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 2,
        title: !isSearching
            ? Text(
                "Movies",
                style: heading.copyWith(fontSize: 18),
              )
            : TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Ara",
                  hintStyle: normalText,
                  focusColor: primaryColor,
                ),
                onSubmitted: (text) {
                  setState(() {
                    futureAlbum = httpService.getMovie(
                        "https://yts.mx/api/v2/list_movies.json?query_term=$text");
                  });
                },
              ),
        actions: [
          IconButton(
            onPressed: (() {
              setState(() {
                this.isSearching = !isSearching;
              });
            }),
            icon: Icon(
              Icons.search,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: FutureBuilder<Movie>(
        future: futureAlbum,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            Movie movie = snapshot.data!;
            return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme:
                      ColorScheme.fromSwatch(accentColor: primaryAccent)),
              child: Container(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 24),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(
                      // Heading
                      child: SafeArea(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      )),
                    ),
                    SliverGrid(
                      // GRID MEDIA
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 24.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.75),
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: movie.movie!.length,
                        (context, index) {
                          return Container(
                            child: InkResponse(
                                enableFeedback: true,
                                splashColor: primaryColor,
                                child: Stack(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(18)),
                                    child: Image.network(
                                      snapshot.data!.movie![index]
                                          ["medium_cover_image"],
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                      // color: primaryColor.withOpacity(.5),
                                      // colorBlendMode: BlendMode.modulate,
                                      errorBuilder:
                                          ((context, error, stackTrace) {
                                        print(error);
                                        return Center(
                                          child: Text(
                                            "Olmadı",
                                            style: normalText,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10.0, sigmaY: 10.0),
                                          child: Container(
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color: ligthDark.withOpacity(0.2),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                              ),
                                              child: Text(
                                                snapshot.data!.movie![index]
                                                    ["title"],
                                                style: normalText.copyWith(
                                                    fontSize: 13),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )),
                                          ),
                                        ),

                                        // child: Center(
                                        //     child: Text(
                                        //   snapshot.data!.movie![index]["title"],
                                        //   style: normalText,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   maxLines: 2,
                                        // )),
                                      ))
                                ]),
                                onTap: () {
                                  goToMoviePage(snapshot.data, index);
                                }),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return CustomCircularProgres();
          }
        }),
      ),
    );
  }

  goToMoviePage(Movie? data, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MoviePage(
          movieData: data,
          title: data!.movie![index]['title'],
          summary: data.movie![index]['summary'],
          id: index);
    }));
  }
}
