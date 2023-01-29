import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/movie.dart';

class HttpHelper{
/*
Kelas ini digunakan untuk mendapatkan data dari themoviedb
dengan metode Upcoming yang memberikan nilai return berupa teks
*/

  final String urlKey = 'api_key=a25ad8ece758123dc57784e37f5583fa'; //1
  final String urlBase = 'https://api.themoviedb.org/3/movie'; //2
  final String urlUpcoming = '/upcoming?'; //3
  final String urlLanguage = '&language=en-US'; //4
  final String urlSearchBase = 'htpps://api.themoviedb.org/3/movie/search/movie?api_key=a25ad8ece758123dc57784e37f5583fa&query=';
  Future<String> getUpcoming() async{ //5
    final Uri upcoming = Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);

//6

    http.Response result = await http.get(upcoming); //7
    if(result.statusCode == HttpStatus.ok){ //8
      String responseBody = result.body;
      return responseBody; //9
    }
    else {
      return '{}'; //10
    }
  }
  Future<List> getUpComingAsList() async {
    final Uri upcoming =
    Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(result.body); //1
      final movieObjects = jsonResponseBody['results']; //2
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List> findMovies(String title) async {
    final Uri query = Uri.parse(urlSearchBase + title);
    http.Response result = await http.get(query);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(result.body); //1
      final movieObjects = jsonResponseBody['results']; //2
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      return [];
    }
  }

}