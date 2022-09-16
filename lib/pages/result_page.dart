import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:video_player/pages/bottom_navigation_bar.dart';

import '../constants.dart';
import '../data/http_service.dart';
import '../model/movie_card_model.dart';
import 'movie_page.dart';

class ResultPage extends StatefulWidget {
  final String genre;

  const ResultPage({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final HttpService httpService = HttpService();
  late Future<Movie> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = httpService.getMovie(
        "https://yts.mx/api/v2/list_movies.json?genre=${widget.genre}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          widget.genre,
          style: movieHeadText.copyWith(fontSize: 20),
        ),
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
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(
                      // Heading
                      child: SafeArea(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                    ),
                    SliverGrid(
                      // GRID MEDIA
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.4),
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: movie.movie!.length,
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: InkResponse(
                                enableFeedback: true,
                                splashColor: primaryColor,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(20, 50)),
                                  child: Image.network(
                                    snapshot.data!.movie![index]
                                        ["large_cover_image"],
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
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        }),
      ),
    );
  }

  goToMoviePage(Movie? data, int index) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MoviePage(
          movieData: data,
          title: data!.movie![index]['title'],
          summary: data.movie![index]['summary'],
          id: index);
    }));
  }
}
