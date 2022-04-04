import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models_imports.dart';
import 'package:peliculas/models/movies_populares.dart';

class MovieProvider extends ChangeNotifier {
  //Variables Peliculas de carteleras
  String apikey = '44e9badbced75729bf15f396a7e498a2';
  String baseUrl = 'api.themoviedb.org';
  String language = 'es-ES';
  String cadena = '3/movie/now_playing';
  String page = '1';
  //#####################################

  List<Movie> listadoP = [];
  List<Movie> listadopopulares = [];
  Map<int, List<Cast>> moviecast = {};
  int _popularpag = 0;
  MovieProvider() {
    this.getOndisplaymovie();
    this.getOndisplayPopular();
  }
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(baseUrl, endpoint,
        {'api_key': apikey, 'language': language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  getOndisplaymovie() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final decodate = NowPlayingResponse.fromJson(jsonData);

    // print(decodate.results[1].title);
    listadoP = decodate.results;
    notifyListeners();
  }

  getOndisplayPopular() async {
    _popularpag++;
    final jsonData = await _getJsonData('3/movie/popular', _popularpag);
    final ppularpelis = MoviesPopular.fromJson(jsonData);

    listadopopulares = [...listadopopulares, ...ppularpelis.results];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviecast.containsKey(movieId)) return moviecast[movieId]!;

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviecast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(baseUrl, '/3/search/movie',
        {'api_key': apikey, 'language': language, 'query': query});
    final response = await http.get(url);
    final searchMovies = SearchMovie.fromJson(response.body);

    return searchMovies.results;
  }
}
