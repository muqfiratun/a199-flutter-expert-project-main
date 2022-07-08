import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series_tv_remote_data_source.dart';
import 'package:ditonton/data/models/detail_model_series_tv.dart';
import 'package:ditonton/data/models/response_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late RemoteSeriesTvDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteSeriesTvDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air Tv Series', () {
    final tTvSeriesList = ResponseSeriesTv.fromJson(
        json.decode(readJson('dummy_data/on_the_air.json')))
        .tvList;

    test('should return list of Tv Series Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_the_air.json'), 200));
          // act
          final result = await dataSource.getNowPlayingSeriesTv();
          // assert
          expect(result, equals(tTvSeriesList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getNowPlayingSeriesTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Tv Series', () {
    final tTvSeriesList = ResponseSeriesTv.fromJson(
        json.decode(readJson('dummy_data/popular_series_tv.json')))
        .tvList;

    test('should return list of tv series when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_series_tv.json'), 200));
          // act
          final result = await dataSource.getPopularSeriesTv();
          // assert
          expect(result, tTvSeriesList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularSeriesTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Tv Series', () {
    final tTvSeriesList = ResponseSeriesTv.fromJson(
        json.decode(readJson('dummy_data/top_rated_series_tv.json')))
        .tvList;

    test('should return list of tv series when response code is 200 ',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/top_rated_series_tv.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          // act
          final result = await dataSource.getTopRatedSeriesTv();
          // assert
          expect(result, tTvSeriesList);
        });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response(
            'Not Found',
            404,
          ));
          // act
          final call = dataSource.getTopRatedSeriesTv();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Tv Series detail', () {
    final tId = 1;
    final tTvSeriesDetail = DetailResponseSeriesTv.fromJson(
        json.decode(readJson('dummy_data/series_tv_detail.json')));

    test('should return tv series detail when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series_tv_detail.json'), 200,
              headers: {
                HttpHeaders.contentTypeHeader:
                'application/json; charset=utf-8',
              }));
          // act
          final result = await dataSource.getDetailSeriesTv(tId);
          // assert
          expect(result, equals(tTvSeriesDetail));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getDetailSeriesTv(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Tv Series recommendations', () {
    final tTvSeriesList = ResponseSeriesTv.fromJson(
        json.decode(readJson('dummy_data/series_tv_recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of  Series Tv Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series_tv_recommendations.json'), 200));
          // act
          final result = await dataSource.getRecommendationsSeriesTv(tId);
          // assert
          expect(result, equals(tTvSeriesList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getRecommendationsSeriesTv(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search Tv Series', () {
    final tSearchResult = ResponseSeriesTv.fromJson(
        json.decode(readJson('dummy_data/search_halo_series_tv.json')))
        .tvList;
    final tQuery = 'Halo';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_halo_series_tv.json'), 200));
      // act
      final result = await dataSource.searchSeriesTv(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.searchSeriesTv(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}