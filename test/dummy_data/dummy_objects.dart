import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/table_series_tv.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season_tv.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testSeriesTv = SeriesTv(
  backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
  firstAirDate: "2003-10-21",
  genreIds: [18],
  id: 11250,
  name: "Hidden Passion",
  originCountry: ["CO"],
  originalLanguage: "es",
  originalName: "Pasión de gavilanes",
  overview:
  "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
  popularity: 1747.047,
  posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
  voteAverage: 7.6,
  voteCount: 1803,
);

final testMovieList = [testMovie];
final testSeriesTvList = [testSeriesTv];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testSeriesTvDetail = DetailSeriesTv(
  adult: false,
  backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
  episodeRunTime: [42],
  genres: [Genre(id: 18, name: 'Drama')],
  homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
  id: 1,
  name: "name",
  numberOfEpisodes: 259,
  numberOfSeasons: 2,
  originalName: "Pasión de gavilanes",
  overview: "overview",
  popularity: 1747.047,
  posterPath: "posterPath",
  seasons: [
    Season(
      episodeCount: 188,
      id: 72643,
      name: "Season 1",
      posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
      seasonNumber: 1,
    )
  ],
  status: "Returning Series",
  type: "Scripted",
  voteAverage: 7.6,
  voteCount: 1803,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistSeriesTv = SeriesTv.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesTvTable = TableSeriesTv(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testSeriesTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};