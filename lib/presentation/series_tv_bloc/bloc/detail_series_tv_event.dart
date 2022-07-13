part of 'detail_series_tv_bloc.dart';

abstract class DetailSeriesTvEvent extends Equatable {
  const DetailSeriesTvEvent();
}
class OnDetailSeriesTvShow extends DetailSeriesTvEvent {
  final int id;

  OnDetailSeriesTvShow(this.id);

  @override
  List<Object> get props => [];
}
