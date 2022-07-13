import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/detail_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/recommendations_series_tv_bloc.dart';
import 'package:ditonton/presentation/series_tv_bloc/bloc/watchlist_series_tv_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_page_series_tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPageSeriesTv extends StatefulWidget {
  static const ROUTE_NAME = '/detail_SeriesTv';

  final int id;
  DetailPageSeriesTv({required this.id});

  @override
  _DetailPageStateSeriesTv createState() => _DetailPageStateSeriesTv();
}

class _DetailPageStateSeriesTv extends State<DetailPageSeriesTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailSeriesTvBloc>().add(OnDetailSeriesTvShow(widget.id));
      context
          .read<RecommendationSeriesTvBloc>()
          .add(OnRecommendationSeriesTvShow(widget.id));
      context.read<WatchlistSeriesTvBloc>().add(WatchlistSeriesTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
  final watchlistStatus =
    context.select<WatchlistSeriesTvBloc, bool>((value) {
      if (value.state is InsertWatchlist) {
        return (value.state as InsertWatchlist).status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<DetailSeriesTvBloc, DetailSeriesTvState>(
        builder: (context, state) {
          if (state is DetailSeriesTvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailSeriesTvHasData) {
            final SeriesTv = state.result;
            return SafeArea(
              child: DetailContent(
                SeriesTv,
                watchlistStatus,
              ),
            );
          } else if (state is DetailSeriesTvError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final DetailSeriesTv SeriesTv;
  late bool isAddedWatchlist;

  DetailContent(this.SeriesTv, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
          'https://image.tmdb.org/t/p/w500${widget.SeriesTv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.SeriesTv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedWatchlist) {
                                  context.read<WatchlistSeriesTvBloc>().add(
                                      InsertWatchlistSeriesTv(widget.SeriesTv));
                                } else {
                                  context.read<WatchlistSeriesTvBloc>().add(
                                      DeleteWatchlistSeriesTv(widget.SeriesTv));
                                }

                                final state =
                                    BlocProvider.of<WatchlistSeriesTvBloc>(
                                        context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String removeMessage = "Removed from Watchlist";

                                if (state is InsertWatchlist) {
                                  final isAdded = state.status;
                                  if (isAdded == false) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                } else {
                                  if (!widget.isAddedWatchlist) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                }

                                if (message == insertMessage ||
                                    message == removeMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      action: SnackBarAction(
                                        label: 'See Watchlist',
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              WatchlistPageSeriesTv.ROUTE_NAME);
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isAddedWatchlist =
                                  !widget.isAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.SeriesTv.genres),
                            ),
                            Text(
                              _showSeasonEpisode(
                                  widget.SeriesTv.numberOfSeasons,
                                  widget.SeriesTv.numberOfEpisodes),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.SeriesTv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.SeriesTv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.SeriesTv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationSeriesTvBloc,
                                RecommendationSeriesTvState>(
                              builder: (context, state) {
                                if (state is RecommendationSeriesTvLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                is RecommendationSeriesTvError) {
                                  return Text(state.message);
                                } else if (state
                                is RecommendationSeriesTvHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final SeriesTv = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                DetailPageSeriesTv.ROUTE_NAME,
                                                arguments: SeriesTv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${SeriesTv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else {
                                  return Text('There is no recommendations');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showSeasonEpisode(int numberOfSeason, int numberOsEpisode) {
    return '${numberOfSeason} season, ${numberOsEpisode} episode';
  }
}