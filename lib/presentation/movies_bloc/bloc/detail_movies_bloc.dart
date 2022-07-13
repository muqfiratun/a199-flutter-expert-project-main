import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final GetMovieDetail _getMovieDetail;
  DetailMoviesBloc(this._getMovieDetail) : super(DetailMoviesEmpty()) {
    on<OnDetailMoviesShow>((event, emit) async {
      final id = event.id;

      emit(DetailMoviesLoading());
      final result = await _getMovieDetail.execute(id);
      result.fold((failure){
        emit(DetailMoviesError(failure.message));
      }, (data){
        emit(DetailMoviesHasData(data));
      });
    });
  }
}
