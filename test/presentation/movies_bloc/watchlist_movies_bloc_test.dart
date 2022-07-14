import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/watchlist_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistMoviesBloc watchlistMoviesBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatusMovies mockGetWatchListStatusMovies;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatusMovies = MockGetWatchListStatusMovies();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovies = MockRemoveWatchlistMovie();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatusMovies,
      mockRemoveWatchlistMovies,
      mockSaveWatchlistMovie,
    );
  });

  const tId = 1;

  final testDetailMovies = MovieDetail(
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

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  group('bloc watch list movie testing', () {
    test('initial state should be empty', () {
      expect(watchlistMoviesBloc.state, WatchlistMoviesEmpty());
    });

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovies()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        return OnWatchlistMovies().props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovies()),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesError('Server Failure'),
      ],
      verify: (bloc) => WatchlistMoviesLoading(),
    );
  });

  group('bloc status watch list movie testing', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => true);
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovies(tId)),
      expect: () => [InsertWatchlist(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusMovies.execute(tId));
        return WatchlistMovies(tId).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchListStatusMovies.execute(tId))
            .thenAnswer((_) async => false);
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(WatchlistMovies(tId)),
      expect: () => [InsertWatchlist(false)],
      verify: (bloc) => WatchlistMoviesLoading(),
    );
  });

  group('bloc add watch list movie testing', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSaveWatchlistMovie.execute(testDetailMovies))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovies(testDetailMovies)),
      expect: () => [
        WatchlistMoviesLoading(),
        MessageWatchlist('Added to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(testDetailMovies));
        return InsertWatchlistMovies(testDetailMovies).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSaveWatchlistMovie.execute(testDetailMovies)).thenAnswer(
                (_) async => Left(DatabaseFailure('Added to Watchlist Fail')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(InsertWatchlistMovies(testDetailMovies)),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesError('Added to Watchlist Fail'),
      ],
      verify: (bloc) => InsertWatchlistMovies(testDetailMovies),
    );
  });

  group('bloc remove watch list movie testing', () {
    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockRemoveWatchlistMovies.execute(testDetailMovies))
            .thenAnswer((_) async => Right('Delete to Watchlist'));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovies(testDetailMovies)),
      expect: () => [
        MessageWatchlist('Delete to Watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovies.execute(testDetailMovies));
        return DeleteWatchlistMovies(testDetailMovies).props;
      },
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockRemoveWatchlistMovies.execute(testDetailMovies)).thenAnswer(
                (_) async => Left(DatabaseFailure('Delete to Watchlist Fail')));
        return watchlistMoviesBloc;
      },
      act: (bloc) => bloc.add(DeleteWatchlistMovies(testDetailMovies)),
      expect: () => [
        WatchlistMoviesError('Delete to Watchlist Fail'),
      ],
      verify: (bloc) => DeleteWatchlistMovies(testDetailMovies),
    );
  });
}