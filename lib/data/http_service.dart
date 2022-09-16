import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/movie_card_model.dart';

class HttpService {
  // http.Client client = http.Client();
  // final _apiKey = '9c9576f8c2e86949a3220fcc32ae2fb6';
  // final _baseUrl = "http://api.themoviedb.org/3/movie";

  // final String postsURL = "https://jsonplaceholder.typicode.com/posts";
  final postsURL = "https://yts.mx/api/v2/list_movies.json?limit=20";
  var movieData;
  var postData;

  Future<Movie> getMovie(String postUrl) async {
    final res = await http.get(Uri.parse(postUrl));
    if (res.statusCode == 200) {
      //print(res.body);
      movieData = Movie.fromJson(jsonDecode(res.body));
      return movieData;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<Post> getPost() async {
    postData = getMovie(postsURL);
    Post post = postData as Post;
    print(postData);
    return postData;
  }
}
