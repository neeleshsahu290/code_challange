import 'package:equatable/equatable.dart';

import 'datum.dart';

class DataSet extends Equatable {
  final List<RoomsNeed>? data;

  const DataSet({this.data});

  factory DataSet.fromJson(Map<String, dynamic> json) => DataSet(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => RoomsNeed.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [data];
}
