part of 'top_rated_series_tv_bloc.dart';

abstract class TopRatedSeriesTvState extends Equatable {
  const TopRatedSeriesTvState();
  @override
  List<Object> get props => [];
}

class TopRatedSeriesTvEmpty extends TopRatedSeriesTvState {
  @override
  List<Object> get props => [];
}

class TopRatedSeriesTvLoading extends TopRatedSeriesTvState {
  @override
  List<Object> get props => [];
}

class TopRatedSeriesTvError extends TopRatedSeriesTvState {
  final String message;

  TopRatedSeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedSeriesTvHasData extends TopRatedSeriesTvState {
  final List<SeriesTv> result;

  TopRatedSeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
