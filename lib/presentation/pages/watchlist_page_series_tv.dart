
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/watchlist_series_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/list_card_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistPageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist_SeriesTv';

  @override
  State<WatchlistPageSeriesTv> createState() => _WatchlistPageStateSeriesTv();
}

class _WatchlistPageStateSeriesTv extends State<WatchlistPageSeriesTv> with RouteAware{
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistSeriesTvBloc>().add(OnWatchlistSeriesTv());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistSeriesTvBloc>().add(OnWatchlistSeriesTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistSeriesTvBloc, WatchlistSeriesTvState>(
          builder: (context, state) {
            if (state is WatchlistSeriesTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistSeriesTvHasData) {
              final result = state.result;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return SeriesTvCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  ),
                ],
              );
            } else if (state is WatchlistSeriesTvEmpty) {
              return Center(
                child: Text("No watch list yet"),
              );
            } else if (state is WatchlistSeriesTvError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text("Error get data watch list"),
              );
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
