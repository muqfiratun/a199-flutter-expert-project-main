import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series_tv.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/airing_today_series_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'airing_today_series_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingSeriesTv])
void main() {
  late AiringTodaySeriesTvBloc airingTodaySeriesTvBloc;
  late MockGetAiringTodaySeriesTv mockGetAiringTodaySeriesTv;

  setUp(() {
    mockGetAiringTodaySeriesTv = MockGetAiringTodaySeriesTv();
    airingTodaySeriesTvBloc =
        AiringTodaySeriesTvBloc(mockGetAiringTodaySeriesTv);
  });

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

  group('bloc airing today tv series testing', () {
    test('initial state should be empty', () {
      expect(airingTodaySeriesTvBloc.state, AiringTodaySeriesTvEmpty());
    });

    blocTest<AiringTodaySeriesTvBloc, AiringTodaySeriesTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodaySeriesTv.execute())
            .thenAnswer((_) async => Right(tSeriesTvList));
        return airingTodaySeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnAiringTodaySeriesTvShow()),
      expect: () => [
        AiringTodaySeriesTvLoading(),
        AiringTodaySeriesTvHasData(tSeriesTvList),
      ],
      verify: (bloc) {
        verify(mockGetAiringTodaySeriesTv.execute());
        return OnAiringTodaySeriesTvShow().props;
      },
    );

    blocTest<AiringTodaySeriesTvBloc, AiringTodaySeriesTvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetAiringTodaySeriesTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return airingTodaySeriesTvBloc;
      },
      act: (bloc) => bloc.add(OnAiringTodaySeriesTvShow()),
      expect: () => [
        AiringTodaySeriesTvLoading(),
        AiringTodaySeriesTvError('Server Failure'),
      ],
      verify: (bloc) => AiringTodaySeriesTvLoading(),
    );
  });
}