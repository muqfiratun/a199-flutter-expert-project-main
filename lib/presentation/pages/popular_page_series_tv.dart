import 'package:ditonton/presentation/series_tv_bloc/bloc/popular_series_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/list_card_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularPageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = '/popular-SeriesTv';

  @override
  State<PopularPageSeriesTv> createState() =>  _PopularPageStateSeriesTv();
}

class  _PopularPageStateSeriesTv extends State<PopularPageSeriesTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularSeriesTvBloc>().add(OnPopularSeriesTvShow());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular SeriesTv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularSeriesTvBloc, PopularSeriesTvState>(
          builder: (context, state) {
            if (state is PopularSeriesTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesTvHasData) {
              final result = state.result;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final SeriesTv = result[index];
                  return SeriesTvCard(SeriesTv);
                },
                itemCount: result.length,
              );
            } else if (state is PopularSeriesTvError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                key: Key('no_data_message'),
                child: Text("No popular shows"),
              );
            }
          },
        ),
      ),
    );
  }
}
