part of 'detail_movies_bloc.dart';

abstract class DetailMoviesEvent extends Equatable {
  const DetailMoviesEvent();

}
class OnDetailMoviesShow extends DetailMoviesEvent {
  final int id;

  OnDetailMoviesShow(this.id);

  @override
  List<Object> get props => [];
}