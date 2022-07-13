part of 'popular_series_tv_bloc.dart';

abstract class PopularSeriesTvState extends Equatable {
  const PopularSeriesTvState();
  @override
  List<Object> get props => [];
}

class PopularSeriesTvEmpty extends PopularSeriesTvState {
  @override
  List<Object> get props => [];
}

class PopularSeriesTvLoading extends PopularSeriesTvState {
  @override
  List<Object> get props => [];
}

class PopularSeriesTvError extends PopularSeriesTvState {
  final String message;

  PopularSeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularSeriesTvHasData extends PopularSeriesTvState {
  final List<SeriesTv> result;

  PopularSeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
