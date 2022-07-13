import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/entities/series_tv.dart';

class SeriesTvModel extends Equatable {
    SeriesTvModel({
    required this.id,
    required this.voteCount,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.firstAirDate,
    required this.originalName,
    required this.originalLanguage,
    required this.voteAverage,
    required this.genreIds,
    required this.originCountry,
    required this.popularity,
  });

  final int id;
  final int voteCount;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? firstAirDate;
  final String? originalName;
  final String? originalLanguage;
  final double popularity;
  final double voteAverage;
  final List<int> genreIds;
  final List<String> originCountry;

  factory SeriesTvModel.fromJson(Map<String, dynamic> json) => SeriesTvModel(
      id: json["id"],
      voteCount: json["vote_count"],
      name: json["name"],
      overview: json["overview"],
      posterPath: json["poster_path"]?? '',
      backdropPath: json["backdrop_path"]?? '',
      firstAirDate: json["first_air_date"],
      originalName: json["original_name"],
      originalLanguage: json["original_language"],
      voteAverage: json["vote_average"].toDouble(),
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      originCountry: List<String>.from(json["origin_country"].map((x) => x)),
      popularity: json["popularity"].toDouble(),
  );

  Map<String, dynamic> toJson() =>{
    "id": id,
    "vote_count": voteCount,
    "name": name,
    "overview": overview,
    "poster_path": posterPath,
    "backdrop_path": backdropPath == null ? null : backdropPath,
    "first_air_date": firstAirDate,
    "original_name": originalName,
    "original_language": originalLanguage,
    "vote_average": voteAverage,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "popularity": popularity,
  };

  SeriesTv toEntity(){
    return SeriesTv(
        id: this.id,
        voteCount: this.voteCount,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        originalName: this.originalName,
        originalLanguage: this.originalLanguage,
        voteAverage: this.voteAverage,
        genreIds: this.genreIds,
        originCountry: this.originCountry,
        popularity: this.popularity
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    voteCount,
    name,
    overview,
    posterPath,
    backdropPath,
    firstAirDate,
    originalName,
    originalLanguage,
    voteAverage,
    genreIds,
    originCountry,
    popularity,
  ];
}