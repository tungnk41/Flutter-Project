
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:the_movies_db/Model/movie.dart';

class MovieServiceApi{
  static const String API_KEY = "api_key=e8b165723828dcc8244fcee5f089d3e3";
  static const String BASE_URL = "http://api.themoviedb.org/3/";
  static const String IMAGEURL = "https://image.tmdb.org/t/p/w500/";
  static const String UPCOMING_MOVIE = "movie/upcoming?" + API_KEY + "&language=en-US";
  static const String Search_MOVIE = "search/movie?" + API_KEY + "&query=";

  //http://api.themoviedb.org/3/movie/upcoming?api_key=e8b165723828dcc8244fcee5f089d3e3&language=en-US
  Future<List<Movie>> getUpcomingMovie() async{
    List<Movie> movies = List.empty(growable: true);
    String url = BASE_URL + UPCOMING_MOVIE;
    Uri uri = Uri.parse(url);

    http.Response result = await http.get(uri);
    if(result.statusCode == HttpStatus.ok){
      var jsonResponse = json.decode(result.body);
      var jsonArrayResults = jsonResponse['results'];
      jsonArrayResults.forEach((_result) => movies.add(Movie.fromJson(_result)));
    }else{
      movies = List.empty();
    }
    return movies;
  }

  Future<List<Movie>> searchMovie(String movieTitle) async{
    List<Movie> movies = List.empty(growable: true);
    String url = BASE_URL + Search_MOVIE + movieTitle;
    Uri uri = Uri.parse(url);

    http.Response result = await http.get(uri);
    if(result.statusCode == HttpStatus.ok){
      var jsonResponse = json.decode(result.body);
      var jsonArrayResults = jsonResponse['results'];
      jsonArrayResults.forEach((_result) => movies.add(Movie.fromJson(_result)));
    }else{
      movies = List.empty();
    }
    return movies;
  }


}