part of 'search_series_tv_bloc.dart';

abstract class SearchSeriesTvEvent extends Equatable {
  const SearchSeriesTvEvent();
}
class OnQueryChanged extends SearchSeriesTvEvent {
  final String query;

  OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}