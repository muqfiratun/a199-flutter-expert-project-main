import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:equatable/equatable.dart';

class TableSeriesTv extends Equatable{
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;

  TableSeriesTv({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  factory TableSeriesTv.fromEntity(DetailSeriesTv seriesTv) => TableSeriesTv(
      id: seriesTv.id,
      name: seriesTv.name,
      overview: seriesTv.overview,
      posterPath: seriesTv.posterPath,
  );

  factory TableSeriesTv.fromMap(Map<String,dynamic> map) => TableSeriesTv(
    id: map['id'],
    name: map['name'],
    overview: map['overview'],
    posterPath: map['posterPath'],
  );

  Map<String, dynamic> toJson() =>{
    'id':id,
    'name': name,
    'overview': overview,
    'posterPath':posterPath,
  };

  SeriesTv toEntity() => SeriesTv.watchlist(
      id:id,
      name:name,
      overview: overview,
      posterPath: posterPath,
  );

  @override
  List<Object?> get props => [id,name,overview,posterPath];
}