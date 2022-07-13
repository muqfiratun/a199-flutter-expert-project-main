part of 'search_series_tv_bloc.dart';

abstract class SearchSeriesTvState extends Equatable {
  const SearchSeriesTvState();
  @override
  List<Object> get props => [];
}
class SearchSeriesTvEmpty extends SearchSeriesTvState {}

class SearchSeriesTvLoading extends SearchSeriesTvState {}

class SearchSeriesTvError extends SearchSeriesTvState {
  final String message;

  SearchSeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchSeriesTvHasData extends SearchSeriesTvState {
  final List<SeriesTv> result;

  SearchSeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
