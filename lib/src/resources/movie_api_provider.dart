import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:bloc_tutorial/src/models/item_model.dart';
import'../models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = "0f56cd000a35dbdf90aab6c420bfaa3e";
  final  _baseUrl = "http://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response = await client.get(
        Uri.parse("http://api.themoviedb.org/3/movie/550?api_key=$_apiKey"));
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response = await client.get(Uri.parse("$_baseUrl/$movieId/videos?api_key=$_apiKey"));
    if(response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load trialers");
    }
  }
}
