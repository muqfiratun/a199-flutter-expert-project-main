import 'dart:convert';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/detail_model_series_tv.dart';
import 'package:ditonton/data/models/model_series_tv.dart';
import 'package:ditonton/data/models/response_series_tv.dart';
import 'package:http/http.dart' as http;

abstract class RemoteSeriesTvDataSource{
  Future<List<SeriesTvModel>> getNowPlayingSeriesTv();
  Future<List<SeriesTvModel>> getPopularSeriesTv();
  Future<List<SeriesTvModel>> getTopRatedSeriesTv();
  Future<List<SeriesTvModel>> searchSeriesTv(String query);
  Future<List<SeriesTvModel>> getRecommendationsSeriesTv(int id);
  Future<DetailResponseSeriesTv> getDetailSeriesTv(int id);

}

class RemoteSeriesTvDataSourceImpl implements  RemoteSeriesTvDataSource{
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  RemoteSeriesTvDataSourceImpl({required this.client});

  @override
  Future<List<SeriesTvModel>> getNowPlayingSeriesTv() async{
    final response = await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if(response.statusCode == 200){
      return ResponseSeriesTv.fromJson(json.decode(response.body)).tvList;
    } else{
      throw ServerException();
    }
  }

  @override
  Future<DetailResponseSeriesTv> getDetailSeriesTv(int id) async{
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if(response.statusCode == 200){
      return DetailResponseSeriesTv.fromJson(json.decode(response.body));
    } else{
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesTvModel>> getRecommendationsSeriesTv(int id) async{
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if(response.statusCode == 200){
      return ResponseSeriesTv.fromJson(json.decode(response.body)).tvList;
    } else{
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesTvModel>> getTopRatedSeriesTv() async{
    final response = await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if(response.statusCode == 200){
      return ResponseSeriesTv.fromJson(json.decode(response.body)).tvList;
    } else{
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesTvModel>> searchSeriesTv(String query) async{
    final response = await client.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if(response.statusCode == 200){
      return ResponseSeriesTv.fromJson(json.decode(response.body)).tvList;
    } else{
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesTvModel>> getPopularSeriesTv() async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if(response.statusCode == 200){
      return ResponseSeriesTv.fromJson(json.decode(response.body)).tvList;
    } else{
      throw ServerException();
    }
  }

}