import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/detail_series_tv.dart';
import 'package:ditonton/domain/usecases/get_detail_series_tv.dart';
import 'package:equatable/equatable.dart';

part 'detail_series_tv_event.dart';
part 'detail_series_tv_state.dart';

class DetailSeriesTvBloc
    extends Bloc<DetailSeriesTvEvent, DetailSeriesTvState> {
  final GetDetailSeriesTv _getDetailSeriesTv;
  DetailSeriesTvBloc(this._getDetailSeriesTv) : super(DetailSeriesTvEmpty()) {
    on<OnDetailSeriesTvShow>((event, emit) async {
      final id = event.id;
      emit(DetailSeriesTvLoading());
      final result = await _getDetailSeriesTv.execute(id);

      result.fold(
            (failure) {
          emit(DetailSeriesTvError(failure.message));
        },
            (data) {
          emit(DetailSeriesTvHasData(data));
        },
      );
    });
  }
}
