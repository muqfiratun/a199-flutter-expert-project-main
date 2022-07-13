import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/entities/series_tv.dart';
import 'package:ditonton/domain/usecases/get_now_playing_series_tv.dart';
import 'package:equatable/equatable.dart';

part 'airing_today_series_tv_event.dart';
part 'airing_today_series_tv_state.dart';

class AiringTodaySeriesTvBloc
    extends Bloc<AiringTodaySeriesTvEvent, AiringTodaySeriesTvState> {
  final GetNowPlayingSeriesTv _getairingTodaySeriesTv;

  AiringTodaySeriesTvBloc(this._getairingTodaySeriesTv)
      : super(AiringTodaySeriesTvEmpty()) {
    on<OnAiringTodaySeriesTvShow>((event, emit) async {
      emit(AiringTodaySeriesTvLoading());
      final result = await _getairingTodaySeriesTv.execute();

      result.fold(
            (failure) {
          emit(AiringTodaySeriesTvError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(AiringTodaySeriesTvEmpty());
          } else {
            emit(AiringTodaySeriesTvHasData(data));
          }
        },
      );
    });
  }
}
