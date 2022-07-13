import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_movies_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

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

  group('bloc now playing movie testing', () {
    test('initial state should be empty', () {
      expect(nowPlayingMoviesBloc.state, NowPlayingMoviesEmpty());
    });

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMoviesShow()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
        return OnNowPlayingMoviesShow().props;
      },
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMoviesShow()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError('Server Failure'),
      ],
      verify: (bloc) => NowPlayingMoviesLoading(),
    );
  });
}