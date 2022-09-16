import 'package:flutter/material.dart';

class Post {
  final int id;
  final String title;
  final String summary;
  final String coverImage;

  Post({
    required this.id,
    required this.title,
    required this.summary,
    required this.coverImage,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json['title'],
      summary: json['summary'],
      coverImage: json['large_cover_image'],
    );
  }
}

class Movie {
  final List<dynamic>? movie;
  final int movieCount;

  Movie({
    required this.movie,
    required this.movieCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movie: json["data"]["movies"],
      movieCount: json["data"]["movie_count"],
    );
  }
}
