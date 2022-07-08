
import 'dart:convert';

import 'package:ditonton/data/models/model_series_tv.dart';
import 'package:ditonton/data/models/response_series_tv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = SeriesTvModel(
    backdropPath: 'backdropPath',
    firstAirDate: "2021-09-03",
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ["US"],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvSeriesResponseModel =
  ResponseSeriesTv(tvList: <SeriesTvModel>[tTvSeriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = ResponseSeriesTv.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "backdropPath",
            "first_air_date": "2021-09-03",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "name",
            "origin_country": ["US"],
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1,
            "poster_path": "posterPath",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}