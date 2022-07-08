import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/popular_notifier_series_tv.dart';
import 'package:ditonton/presentation/widgets/list_card_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularPageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';

  @override
  State<PopularPageSeriesTv> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularPageSeriesTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvNotifier>(context, listen: false)
            .fetchPopularTv());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TvSeries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.series[index];
                  return SeriesTvCard(series);
                },
                itemCount: data.series.length,
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
