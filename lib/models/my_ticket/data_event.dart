import 'package:json_annotation/json_annotation.dart';
part 'data_event.g.dart';
@JsonSerializable()
class DataEvent {
  int id;
  String name;
  String description;
  String poster;
  int duration;
  int discount;
  @JsonKey(name: 'hosted_at')
  String hostedAt;
  @JsonKey(name: 'ended_at')
  String endedAt;

  @JsonKey(name: 'discounted_from')
  String discountedFrom;
  @JsonKey(name: 'discounted_to')
  String discountedTo;

  DataEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.poster,
    required this.duration,
    required this.discount,
    required this.hostedAt,
    required this.endedAt,
    required this.discountedFrom,
    required this.discountedTo});

  factory DataEvent.fromJson(Map<String, dynamic> json) => _$DataEventFromJson(json);
  Map<String, dynamic> toJson() => _$DataEventToJson(this);
}