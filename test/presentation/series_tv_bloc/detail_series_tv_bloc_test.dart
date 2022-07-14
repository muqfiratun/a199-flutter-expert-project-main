import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season_tv.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_detail_series_tv.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/detail_series_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_series_tv_bloc_test.mocks.dart';

@GenerateMocks([GetDetailSeriesTv])
void main() {
  late DetailSeriesTvBloc detailSeriesTvBloc;
  late MockGetDetailSeriesTv mockGetDetailSeriesTv;

  setUp(() {
    mockGetDetailSeriesTv = MockGetDetailSeriesTv();
    detailSeriesTvBloc = DetailSeriesTvBloc(mockGetDetailSeriesTv);
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

  group('bloc detail tv series testing', () {
    test('initial state should be empty', () {
      expect(detailSeriesTvBloc.state, DetailSeriesTvEmpty());
    });

    blocTest<DetailSeriesTvBloc, DetailSeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetDetailSeriesTv.execute(tId))
            .thenAnswer((_) async => Right(testDetailSeriesTv));
        return detailSeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnDetailSeriesTvShow(tId)),
      expect: () => [
        DetailSeriesTvLoading(),
        DetailSeriesTvHasData(testDetailSeriesTv),
      ],
      verify: (bloc) {
        verify(mockGetDetailSeriesTv.execute(tId));
        return OnDetailSeriesTvShow(tId).props;
      },
    );

    blocTest<DetailSeriesTvBloc, DetailSeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetDetailSeriesTv.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailSeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnDetailSeriesTvShow(tId)),
      expect: () => [
        DetailSeriesTvLoading(),
        DetailSeriesTvError('Server Failure'),
      ],
      verify: (bloc) => DetailSeriesTvLoading(),
    );
  });
}
