import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/detail_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'detail_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMoviesBloc detailMoviesBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMoviesBloc = DetailMoviesBloc(mockGetMovieDetail);
  });

  final tId = 1;

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

  group('bloc detail movie testing', () {
    test('initial state should be empty', () {
      expect(detailMoviesBloc.state, DetailMoviesEmpty());
    });

    blocTest<DetailMoviesBloc, DetailMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return detailMoviesBloc;
      },
      act: (bloc) => bloc.add(OnDetailMoviesShow(tId)),
      expect: () => [
        DetailMoviesLoading(),
        DetailMoviesHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        return OnDetailMoviesShow(tId).props;
      },
    );

    blocTest<DetailMoviesBloc, DetailMoviesState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailMoviesBloc;
      },
      act: (bloc) => bloc.add(OnDetailMoviesShow(tId)),
      expect: () => [
        DetailMoviesLoading(),
        DetailMoviesError('Server Failure'),
      ],
      verify: (bloc) => DetailMoviesLoading(),
    );
  });
}