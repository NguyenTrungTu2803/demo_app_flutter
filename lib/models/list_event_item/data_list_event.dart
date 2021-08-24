import 'package:flutter_app_beats/models/detail/data_place.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data_tags.dart';
import 'event_category.dart';
part 'data_list_event.g.dart';

@JsonSerializable()
class DataListEvent {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "duration")
  int duration;
  @JsonKey(name: 'event_category')
  EventCategory eventCategory;
  @JsonKey(name: 'poster')
  String poster;
  @JsonKey(name: 'hosted_at')
  String hostedAt;
  @JsonKey(name: 'ended_at')
  String endedAt;
  @JsonKey(name: 'discounted_from')
  String discountedFrom;
  @JsonKey(name: 'discounted_to')
  String discountedTo;
  @JsonKey(name:'place')
  DataPlace place;
  @JsonKey(name: 'tags')
  List<DataTags> dataTags;
  DataListEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.eventCategory,
    required this.discountedFrom,
    required this.discountedTo,
    required this.endedAt,
    required this.hostedAt,
    required this.poster,
    required this.place,
    required this.dataTags
  });
  factory DataListEvent.fromJson(Map<String, dynamic> json) =>
      _$DataListEventFromJson(json);
  Map<String, dynamic> toJson() => _$DataListEventToJson(this);
}
