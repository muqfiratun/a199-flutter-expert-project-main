part of 'detail_series_tv_bloc.dart';

abstract class DetailSeriesTvState extends Equatable {
  const DetailSeriesTvState();
  @override
  List<Object> get props => [];
}
class DetailSeriesTvEmpty extends DetailSeriesTvState {
  @override
  List<Object> get props => [];
}

class DetailSeriesTvLoading extends DetailSeriesTvState {
  @override
  List<Object> get props => [];
}

class DetailSeriesTvError extends DetailSeriesTvState {
  String message;
  DetailSeriesTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailSeriesTvHasData extends DetailSeriesTvState {
  final DetailSeriesTv result;

  DetailSeriesTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
