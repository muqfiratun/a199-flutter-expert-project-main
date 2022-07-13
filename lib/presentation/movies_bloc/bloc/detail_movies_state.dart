part of 'detail_movies_bloc.dart';


abstract class DetailMoviesState extends Equatable {
  const DetailMoviesState();
  @override
  List<Object> get props => [];
}

class DetailMoviesEmpty extends DetailMoviesState {
  @override
  List<Object> get props => [];
}

class DetailMoviesLoading extends DetailMoviesState {
  @override
  List<Object> get props => [];
}
class DetailMoviesError extends DetailMoviesState {
  String message;
  DetailMoviesError(this.message);
  @override
  List<Object> get props => [message];
}
class DetailMoviesHasData extends DetailMoviesState {
  final MovieDetail result;
  DetailMoviesHasData(this.result);
  @override
  List<Object> get props => [result];
}