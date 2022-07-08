import 'package:equatable/equatable.dart';

class Season extends Equatable {
  int id;
  int seasonNumber;
  int episodeCount;
  String name;
  String posterPath;

  Season({
        required this.id,
        required this.seasonNumber,
        required this.episodeCount,
        required this.name,
        required this.posterPath,
        });

  @override
  List<Object?> get props => [
    id,
    seasonNumber,
    episodeCount,
    name,
    posterPath,
  ];
}