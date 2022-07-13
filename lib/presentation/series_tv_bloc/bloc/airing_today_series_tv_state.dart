part of 'airing_today_series_tv_bloc.dart';

abstract class AiringTodaySeriesTvState extends Equatable {
  const AiringTodaySeriesTvState();
  @override
  List<Object> get props => [];
}

class AiringTodaySeriesTvEmpty extends AiringTodaySeriesTvState {
  @override
  List<Object> get props => [];
}

class AiringTodaySeriesTvLoading extends AiringTodaySeriesTvState {
  @override
  List<Object> get props => [];
}

class AiringTodaySeriesTvError extends AiringTodaySeriesTvState {
  final String message;

  AiringTodaySeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class AiringTodaySeriesTvHasData extends AiringTodaySeriesTvState {
  final List<SeriesTv> result;

  AiringTodaySeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
