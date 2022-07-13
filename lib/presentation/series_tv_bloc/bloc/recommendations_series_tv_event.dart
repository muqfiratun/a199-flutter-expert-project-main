part of 'recommendations_series_tv_bloc.dart';

abstract class RecommendationSeriesTvEvent extends Equatable {
  const RecommendationSeriesTvEvent();
}
class OnRecommendationSeriesTvShow extends RecommendationSeriesTvEvent {
  final int id;

  OnRecommendationSeriesTvShow(this.id);

  @override
  List<Object?> get props => [];
}