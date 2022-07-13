import 'package:ditonton/presentation/movies_bloc/bloc/detail_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/recommendations_movies_bloc.dart';
import 'package:ditonton/presentation/movies_bloc/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test/dummy_data/dummy_objects.dart';
import '../../test/helpers/movies_helper.dart';

void main() {
  late FakeDetailMoviesBloc fakeDetailMoviesBloc;
  late FakeRecommendationsMoviesBloc fakeRecommendationsMoviesBloc;
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;

  setUp(() {
    registerFallbackValue(FakeDetailMoviesEvent());
    registerFallbackValue(FakeDetailMoviesState());
    fakeDetailMoviesBloc = FakeDetailMoviesBloc();

    registerFallbackValue(FakeRecommendationsMoviesEvent());
    registerFallbackValue(FakeRecommendationsMoviesState());
    fakeRecommendationsMoviesBloc = FakeRecommendationsMoviesBloc();

    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMoviesBloc>(
          create: (_) => fakeDetailMoviesBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => fakeWatchlistMoviesBloc,
        ),
        BlocProvider<RecommendationMoviesBloc>(
          create: (_) => fakeRecommendationsMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeDetailMoviesBloc.close();
    fakeWatchlistMoviesBloc.close();
    fakeRecommendationsMoviesBloc.close();
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailMoviesBloc.state).thenReturn(DetailMoviesLoading());
        when(() => fakeRecommendationsMoviesBloc.state)
            .thenReturn(RecommendationMoviesLoading());
        when(() => fakeWatchlistMoviesBloc.state)
            .thenReturn(WatchlistMoviesLoading());

        final viewProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(viewProgress, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(() => fakeDetailMoviesBloc.state).thenReturn(DetailMoviesLoading());
        when(() => fakeRecommendationsMoviesBloc.state)
            .thenReturn(RecommendationMoviesLoading());
        when(() => fakeWatchlistMoviesBloc.state)
            .thenReturn(WatchlistMoviesLoading());

        final viewProgress = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(viewProgress, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(() => fakeDetailMoviesBloc.state)
            .thenReturn(DetailMoviesHasData(testMovieDetail));

        when(() => fakeRecommendationsMoviesBloc.state)
            .thenReturn(RecommendationMoviesHasData(testMovieList));

        when(() => fakeWatchlistMoviesBloc.state).thenReturn(InsertWatchlist(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect((watchlistButton), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(() => fakeDetailMoviesBloc.state)
            .thenReturn(DetailMoviesHasData(testMovieDetail));
        when(() => fakeRecommendationsMoviesBloc.state)
            .thenReturn(RecommendationMoviesHasData(testMovieList));
        when(() => fakeWatchlistMoviesBloc.state).thenReturn(InsertWatchlist(false));

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect((watchlistButton), findsOneWidget);
      });
}