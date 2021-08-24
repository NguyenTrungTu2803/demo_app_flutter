import 'package:flutter_app_beats/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_event_item_model.g.dart';
@JsonSerializable()
class ListEventItemModel{
  @JsonKey(name: "_status")
  int status;
  @JsonKey(name: "_data")
  List<DataListEvent> dataListEvent;
  @JsonKey(name: "_extra")
  Extra extra;

  ListEventItemModel({required this.status,required  this.dataListEvent,required  this.extra});
  factory ListEventItemModel.fromJson(Map<String, dynamic> json) => _$ListEventItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListEventItemModelToJson(this);
}