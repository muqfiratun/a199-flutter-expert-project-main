import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_recommendations_series_tv.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/recommendations_series_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendations_series_tv_bloc_test.mocks.dart';

@GenerateMocks([GetRecommendationsSeriesTv])
void main() {
  late RecommendationSeriesTvBloc recomendationSeriesTvBloc;
  late MockGetRecommendationsSeriesTv mockGetRecommendationSeriesTv;

  setUp(() {
    mockGetRecommendationSeriesTv = MockGetRecommendationsSeriesTv();
    recomendationSeriesTvBloc =
        RecommendationSeriesTvBloc(mockGetRecommendationSeriesTv);
  });

  const tId = 1;

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

  group('bloc recomendation tv series testing', () {
    test('initial state should be empty', () {
      expect(recomendationSeriesTvBloc.state, RecommendationSeriesTvEmpty());
    });

    blocTest<RecommendationSeriesTvBloc, RecommendationSeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetRecommendationSeriesTv.execute(tId))
            .thenAnswer((_) async => Right(tSeriesTvList));
        return recomendationSeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationSeriesTvShow(tId)),
      expect: () => [
        RecommendationSeriesTvLoading(),
        RecommendationSeriesTvHasData(tSeriesTvList),
      ],
      verify: (bloc) {
        verify(mockGetRecommendationSeriesTv.execute(tId));
        return OnRecommendationSeriesTvShow(tId).props;
      },
    );

    blocTest<RecommendationSeriesTvBloc, RecommendationSeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetRecommendationSeriesTv.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return recomendationSeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationSeriesTvShow(tId)),
      expect: () => [
        RecommendationSeriesTvLoading(),
        RecommendationSeriesTvError('Server Failure'),
      ],
      verify: (bloc) => RecommendationSeriesTvLoading(),
    );
  });
}