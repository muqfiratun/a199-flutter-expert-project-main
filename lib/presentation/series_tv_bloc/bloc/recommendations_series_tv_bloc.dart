import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_recommendations_series_tv.dart';
import 'package:equatable/equatable.dart';

part 'recommendations_series_tv_event.dart';
part 'recommendations_series_tv_state.dart';

class RecommendationSeriesTvBloc extends Bloc<RecommendationSeriesTvEvent, RecommendationSeriesTvState> {
  final GetRecommendationsSeriesTv _getRecommendationsSeriesTv;
  RecommendationSeriesTvBloc(this._getRecommendationsSeriesTv) : super(RecommendationSeriesTvEmpty()) {
    on<OnRecommendationSeriesTvShow>((event, emit) async{
      final id = event.id;
      emit(RecommendationSeriesTvLoading());
      final result = await _getRecommendationsSeriesTv.execute(id);

      result.fold(
            (failure) {
          emit(RecommendationSeriesTvError(failure.message));
        },
            (data) {
          emit(RecommendationSeriesTvHasData(data));
        },
      );
    });
  }
}
