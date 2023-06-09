// To parse this JSON data, do
//
//     final popularPlayingResponse = popularPlayingResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models_exports.dart';

class PopularPlayingResponse {
  PopularPlayingResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PopularPlayingResponse.fromJson(String str) =>
      PopularPlayingResponse.fromMap(json.decode(str));

  factory PopularPlayingResponse.fromMap(Map<String, dynamic> json) =>
      PopularPlayingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
