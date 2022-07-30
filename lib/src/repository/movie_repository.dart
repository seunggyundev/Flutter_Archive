import 'dart:convert';

import 'package:archive/src/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieRepository{
  var queryParam = {
    'api_key': 'a33b3aaa10b3fad91905d8baeb41521c',
  };

  Future<List<Movie>> loadMovies() async {
    var uri = Uri.https('api.themoviedb.org', '/3/movie/popular', queryParam);
    var response = await http.get(uri);
    if (response.body != null) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body["results"] != null) {
        List<dynamic> list = body["results"];
        return list.map<Movie>((item) => Movie.fromJson(item)).toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}