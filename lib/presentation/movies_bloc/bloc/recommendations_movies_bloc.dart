import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendations_movies_event.dart';
part 'recommendations_movies_state.dart';

class RecommendationMoviesBloc extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations _getRecommendationMovies;

  RecommendationMoviesBloc(this._getRecommendationMovies)
      : super(RecommendationMoviesEmpty()) {
    on<OnRecommendationMoviesShow>((event, emit) async {
      // TODO: implement event handler
      final id = event.id;

      emit(RecommendationMoviesLoading());
      final result = await _getRecommendationMovies.execute(id);

      result.fold((failure) {
        emit(RecommendationMoviesError(failure.message));
      }, (data) {
        emit(RecommendationMoviesHasData(data));
      });
    });
  }
}
