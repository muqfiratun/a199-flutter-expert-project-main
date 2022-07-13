import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season_tv.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_series_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_series_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_series_tv.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/watchlist_series_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_series_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListSeriesTv,
  GetWatchListStatusSeriesTv,
  SaveWatchlistSeriesTv,
  RemoveWatchlistSeriesTv,
])
void main() {
  late WatchlistSeriesTvBloc watchlistSeriesTvBloc;
  late MockGetWatchlistSeriesTv mockGetWatchlistSeriesTv;
  late MockGetWatchListStatusSeriesTv mockGetWatchListStatusSeriesTv;
  late MockSaveWatchlistSeriesTv mockSaveWatchlistSeriesTv;
  late MockRemoveWatchlistSeriesTv mockRemoveWatchlistSeriesTv;

  setUp(() {
    mockGetWatchlistSeriesTv = MockGetWatchlistSeriesTv();
    mockGetWatchListStatusSeriesTv = MockGetWatchListStatusSeriesTv();
    mockSaveWatchlistSeriesTv = MockSaveWatchlistSeriesTv();
    mockRemoveWatchlistSeriesTv = MockRemoveWatchlistSeriesTv();
    watchlistSeriesTvBloc = WatchlistSeriesTvBloc(
      mockGetWatchlistSeriesTv,
      mockGetWatchListStatusSeriesTv,
      mockRemoveWatchlistSeriesTv,
      mockSaveWatchlistSeriesTv,
    );
  });

  final tId = 1;

  final testDetailSeriesTv = DetailSeriesTv(
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

  final tSeriesTv = SeriesTv(
    backdropPath: "/9hp4JNejY6Ctg9i9ItkM9rd6GE7.jpg",
    firstAirDate: "1997-09-13",
    genreIds: [10764],
    id: 12610,
    name: "Robinson",
    originCountry: ["SE"],
    originalLanguage: "sv",
    originalName: "Robinson",
    overview:
    "Expedition Robinson is a Swedish reality television program in which contestants are put into survival situations, and a voting process eliminates one person each episode until a winner is determined. The format was developed in 1994 by Charlie Parsons for a United Kingdom TV production company called Planet 24, but the Swedish debut in 1997 was the first production to actually make it to television.",
    popularity: 2338.977,
    posterPath: "/sWA0Uo9hkiAtvtjnPvaqfnulIIE.jpg",
    voteAverage: 5,
    voteCount: 3,
  );
  final tSeriesTvList = <SeriesTv>[tSeriesTv];

  group('bloc watch list tv series testing', () {
    test('initial state should be empty', () {
      expect(watchlistSeriesTvBloc.state, WatchlistSeriesTvEmpty());
    });

    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistSeriesTv.execute())
            .thenAnswer((_) async => Right(tSeriesTvList));
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistSeriesTv()),
      expect: () => [
        WatchlistSeriesTvLoading(),
        WatchlistSeriesTvHasData(tSeriesTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistSeriesTv.execute());
        return OnWatchlistSeriesTv().props;
      },
    );

    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistSeriesTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistSeriesTv()),
      expect: () => [
        WatchlistSeriesTvLoading(),
        WatchlistSeriesTvError('Server Failure'),
      ],
      verify: (bloc) => WatchlistSeriesTvLoading(),
    );
  });

  group('bloc status watch list tv series testing', () {
    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListStatusSeriesTv.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistSeriesTv(tId)),
      expect: () => [InsertWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusSeriesTv.execute(tId));
        return WatchlistSeriesTv(tId).props;
      },
    );

    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListStatusSeriesTv.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(WatchlistSeriesTv(tId)),
      expect: () => [InsertWatchlist(false)],
      verify: (bloc) => WatchlistSeriesTvLoading(),
    );
  });

  group('bloc add watch list tv series testing', () {
    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistSeriesTv.execute(testDetailSeriesTv))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistSeriesTv(testDetailSeriesTv)),
      expect: () => [
        WatchlistSeriesTvLoading(),
        MessageWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistSeriesTv.execute(testDetailSeriesTv));
        return InsertWatchlistSeriesTv(testDetailSeriesTv).props;
      },
    );

    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveWatchlistSeriesTv.execute(testDetailSeriesTv)).thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistSeriesTv(testDetailSeriesTv)),
      expect: () => [
        WatchlistSeriesTvLoading(),
        WatchlistSeriesTvError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistSeriesTv(testDetailSeriesTv),
    );
  });

  group('bloc remove watch list tv series testing', () {
    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlistSeriesTv.execute(testDetailSeriesTv))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistSeriesTv(testDetailSeriesTv)),
      expect: () => [
        MessageWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistSeriesTv.execute(testDetailSeriesTv));
        return DeleteWatchlistSeriesTv(testDetailSeriesTv).props;
      },
    );

    blocTest<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveWatchlistSeriesTv.execute(testDetailSeriesTv))
            .thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistSeriesTvBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistSeriesTv(testDetailSeriesTv)),
      expect: () => [
        WatchlistSeriesTvError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistSeriesTv(testDetailSeriesTv),
    );
  });
}