import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_page_series_tv.dart';
import 'package:ditonton/presentation/pages/top_rated_page_series_tv.dart';
import 'package:ditonton/presentation/pages/detail_page_series_tv.dart';
import 'package:ditonton/presentation/pages/search_page_series_tv.dart';
import 'package:ditonton/presentation/pages/watchlist_page_series_tv.dart';
import 'package:ditonton/presentation/provider/list_notifier_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = 'tvseries_homepage';

  @override
  State<HomePageSeriesTv> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomePageSeriesTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () =>
        Provider.of<ListNotifierSeriesTv>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..fetchPopularTv()
          ..fetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv_rounded),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                leading: Icon(Icons.save_alt),
                title: Text('Watchlist'),
                onTap: () {
                  Navigator.pushNamed(context, WatchlistTvSeriesPage.ROUTE_NAME);
                }
            ),

            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPageSeriesTv.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<ListNotifierSeriesTv>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(data.nowPlayingSeriesTv);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => {
                  Navigator.pushNamed(context, PopularPageSeriesTv.ROUTE_NAME)
                },
              ),
              Consumer<ListNotifierSeriesTv>(builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(data.popularTv);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => {
                  Navigator.pushNamed(context, TopRatedPageSeriesTv.ROUTE_NAME)
                },
              ),
              Consumer<ListNotifierSeriesTv>(builder: (context, data, child) {
                final state = data.topRatedStateSeriesTv;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvList(data.topRatedSeriesTv);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<SeriesTv> tvSeries;
  TvList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomePageSeriesTv.ROUTE_NAME,arguments: series.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}



