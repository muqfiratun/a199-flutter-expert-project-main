
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/airing_today_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/popular_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/top_rated_series_tv_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/popular_page_series_tv.dart';
import 'package:ditonton/presentation/pages/top_rated_page_series_tv.dart';
import 'package:ditonton/presentation/pages/detail_page_series_tv.dart';
import 'package:ditonton/presentation/pages/search_page_series_tv.dart';
import 'package:ditonton/presentation/pages/watchlist_page_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeSeriesTvPage extends StatefulWidget {
  static const ROUTE_NAME = 'SeriesTv_homepage';

  @override
  State<HomeSeriesTvPage> createState() => _HomeSeriesTvPageState();
}

class _HomeSeriesTvPageState extends State<HomeSeriesTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AiringTodaySeriesTvBloc>().add(OnAiringTodaySeriesTvShow());
      context.read<PopularSeriesTvBloc>().add(OnPopularSeriesTvShow());
      context.read<TopRatedSeriesTvBloc>().add(OnTopRatedSeriesTvShow());
    });
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
                  Navigator.pushNamed(context, WatchlistPageSeriesTv.ROUTE_NAME);
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
              BlocBuilder<AiringTodaySeriesTvBloc, AiringTodaySeriesTvState>(
                builder: (context, state) {
                  if (state is AiringTodaySeriesTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is AiringTodaySeriesTvHasData) {
                    final data = state.result;
                    return TvList(data);
                  } else if (state is AiringTodaySeriesTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => {
                  Navigator.pushNamed(context, PopularPageSeriesTv.ROUTE_NAME)
                },
              ),
              BlocBuilder<PopularSeriesTvBloc, PopularSeriesTvState>(
                builder: (context, state) {
                  if (state is PopularSeriesTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularSeriesTvHasData) {
                    final data = state.result;
                    return TvList(data);
                  } else if (state is PopularSeriesTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => {
                  Navigator.pushNamed(context, TopRatedPageSeriesTv.ROUTE_NAME)
                },
              ),
              BlocBuilder<TopRatedSeriesTvBloc, TopRatedSeriesTvState>(
                builder: (context, state) {
                  if (state is TopRatedSeriesTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedSeriesTvHasData) {
                    final data = state.result;
                    return TvList(data);
                  } else if (state is TopRatedSeriesTvError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
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
  final List<SeriesTv> seriesTv;
  TvList(this.seriesTv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = seriesTv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailPageSeriesTv.ROUTE_NAME,arguments: series.id);
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
        itemCount: seriesTv.length,
      ),
    );
  }
}



