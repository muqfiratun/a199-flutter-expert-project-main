import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/recommendations_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendations_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMoviesBloc recomendationMoviesBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recomendationMoviesBloc =
        RecommendationMoviesBloc(mockGetMovieRecommendations);
  });

  const tId = 1;

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

  group('bloc recomendation movie testing', () {
    test('initial state should be empty', () {
      expect(recomendationMoviesBloc.state, RecommendationMoviesEmpty());
    });

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovieList));
        return recomendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMoviesShow(tId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
        return OnRecommendationMoviesShow(tId).props;
      },
    );

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recomendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMoviesShow(tId)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesError('Server Failure'),
      ],
      verify: (bloc) => RecommendationMoviesLoading(),
    );
  });
}