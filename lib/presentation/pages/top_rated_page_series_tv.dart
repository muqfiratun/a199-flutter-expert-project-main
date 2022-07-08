import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_rated_notifier_series_tv.dart';
import 'package:ditonton/presentation/widgets/list_card_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedPageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tvseries';

  @override
  State<TopRatedPageSeriesTv> createState() => _TopRatedTvSeriesPageState();


}

class _TopRatedTvSeriesPageState extends State<TopRatedPageSeriesTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedNotifierSeriesTv>(context, listen: false)
            .fetchTopRatedTvSeries());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedNotifierSeriesTv>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.movies[index];
                  return SeriesTvCard(series);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}