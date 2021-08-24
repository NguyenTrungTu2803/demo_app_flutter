import 'package:flutter_app_beats/models/detail/data_user_follows.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data_detail_event.dart';
part 'detail_event_model.g.dart';
@JsonSerializable()
class DetailEventModel{
  @JsonKey(name: '_status')
  int status;
  @JsonKey(name:'_data')
  DataDetailEvent dataDetailEvent;
  DetailEventModel({required this.status,required  this.dataDetailEvent});
  factory DetailEventModel.fromJson(Map<String, dynamic> json) => _$DetailEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$DetailEventModelToJson(this);
}