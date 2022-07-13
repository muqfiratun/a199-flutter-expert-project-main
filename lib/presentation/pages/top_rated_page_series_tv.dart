
import 'package:ditonton/presentation/series_tv_bloc/bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/list_card_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedPageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-SeriesTv';

  @override
  State<TopRatedPageSeriesTv> createState() => _TopRatedPageStateSeriesTv();


}

class _TopRatedPageStateSeriesTv extends State<TopRatedPageSeriesTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedSeriesTvBloc>().add(OnTopRatedSeriesTvShow());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated SeriesTv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedSeriesTvBloc, TopRatedSeriesTvState>(
          builder: (context, state) {
            if (state is TopRatedSeriesTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesTvHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final SeriesTv = result[index];
                  return SeriesTvCard(SeriesTv);
                },
                itemCount: result.length,
              );
            } else if (state is TopRatedSeriesTvError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('no_data_message'),
                child: Text("No top rated shows"),
              );
            }
          },
        ),
      ),
    );
  }
}
