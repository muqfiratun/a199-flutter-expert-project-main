import 'package:ditonton/data/models/model_series_tv.dart';
import 'package:equatable/equatable.dart';

class ResponseSeriesTv extends Equatable{
  final List<SeriesTvModel> tvList;
  ResponseSeriesTv({required this.tvList});

  factory ResponseSeriesTv.fromJson(Map<String,dynamic> json) =>
      ResponseSeriesTv(
        tvList: List<SeriesTvModel>.from((json["results"] as List)
            .map((x) => SeriesTvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );
  Map<String,dynamic> toJson() =>{
    "results": List<dynamic>.from(tvList.map((e) => e.toJson())),
  };

  @override
  List<Object> get props => [tvList];

}