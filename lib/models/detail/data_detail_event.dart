import 'package:flutter_app_beats/models/detail/data_tickets.dart';
import 'package:flutter_app_beats/models/list_event_item/event_category.dart';
import 'package:json_annotation/json_annotation.dart';
import 'data_user_follows.dart';
import 'speakers.dart';
import 'data_place.dart';
part 'data_detail_event.g.dart';

@JsonSerializable()
class DataDetailEvent {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'poster')
  String poster;
  @JsonKey(name: 'place')
  DataPlace place;
  @JsonKey(name: 'duration')
  int duration;
  @JsonKey(name: 'discount')
  int discount;
  @JsonKey(name: 'event_category')
  EventCategory eventCategory;
  @JsonKey(name: 'tickets')
  List<DataTickets> listTickets;
  @JsonKey(name: 'hosted_at')
  String hostedAt;
  @JsonKey(name: 'ended_at')
  String endedAt;
  @JsonKey(name: 'discounted_from')
  String discountedFrom;
  @JsonKey(name: 'discounted_to')
  String discountedTo;
  @JsonKey(name: 'speakers')
  List<Speakers> speakers;
  @JsonKey(name: 'user_follows')
  List<DataUserFollow> userFollows;
  DataDetailEvent(
      {required this.id,
        required this.name,
        required this.description,
        required this.poster,
        required this.place,
        required this.duration,
        required this.discount,
        required this.eventCategory,
        required this.speakers,
        required this.listTickets,
        required this.hostedAt,
        required this.endedAt,
        required this.userFollows,
        required this.discountedFrom,
        required this.discountedTo});
  factory DataDetailEvent.fromJson(Map<String, dynamic> json) =>
      _$DataDetailEventFromJson(json);
  Map<String, dynamic> toJson() => _$DataDetailEventToJson(this);
}
