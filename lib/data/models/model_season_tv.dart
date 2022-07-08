import 'package:ditonton/domain/entities/season_tv.dart';
import 'package:equatable/equatable.dart';

class SeasonTvModel extends Equatable {
  int id;
  int seasonNumber;
  int episodeCount;
  String name;
  String posterPath;

  SeasonTvModel(
      {
        required this.id,
        required this.seasonNumber,
        required this.episodeCount,
        required this.name,
        required this.posterPath,
        });

  factory SeasonTvModel.fromJson(Map<String, dynamic> json) => SeasonTvModel(
      id: json["id"],
      seasonNumber: json["season_number"],
      episodeCount: json["episode_count"],
      name: json["name"],
      posterPath: json["poster_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "season_number": seasonNumber,
    "episode_count": episodeCount,
    "name": name,
    "poster_path": posterPath,
  };

  Season toEntity(){
    return Season(
      id: this.id,
      seasonNumber: this.seasonNumber,
      episodeCount: this.episodeCount,
      name: this.name,
      posterPath: this.posterPath,
    );
  }

  @override
  List<Object?> get props => [
    id,
    seasonNumber,
    episodeCount,
    name,
    posterPath,
  ];
}
