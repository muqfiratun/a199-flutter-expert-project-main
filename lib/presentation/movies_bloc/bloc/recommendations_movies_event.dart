part of 'recommendations_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();
}
class OnRecommendationMoviesShow extends RecommendationMoviesEvent {
  final int id;

  OnRecommendationMoviesShow(this.id);

  @override
  List<Object?> get props => [];
}
