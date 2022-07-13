part of 'recommendations_series_tv_bloc.dart';

abstract class RecommendationSeriesTvState extends Equatable {
  const RecommendationSeriesTvState();
  @override
  List<Object> get props => [];
}

class RecommendationSeriesTvEmpty extends RecommendationSeriesTvState {
  @override
  List<Object> get props => [];
}

class RecommendationSeriesTvLoading extends RecommendationSeriesTvState {
  @override
  List<Object> get props => [];
}

class RecommendationSeriesTvError extends RecommendationSeriesTvState {
  String message;
  RecommendationSeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class RecommendationSeriesTvHasData extends RecommendationSeriesTvState {
  final List<SeriesTv> result;

  RecommendationSeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}