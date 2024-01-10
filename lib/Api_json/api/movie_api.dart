import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:uas_coba/Api_json/models/Movie.dart';

class MovieApi {
  static Future<List<Movie>> fetchAnimes() async {
    const baseUrl = 'https://ghibliapi.vercel.app/films';

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Movie> animes = data
          .map(
            (animeData) => Movie.fromJson(animeData),
          )
          .toList();

      return animes;
    } else {
      print('Error: ${response.body}');
      print('Status Code: ${response.statusCode}');
      throw Exception('Could not retrieve data from api');
    }
  }
}
