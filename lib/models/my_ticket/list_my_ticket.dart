import 'package:flutter_app_beats/models/my_ticket/data_list_my_ticket.dart';
import 'package:json_annotation/json_annotation.dart';
part 'list_my_ticket.g.dart';
@JsonSerializable()
class ListMyTicket{
  @JsonKey(name: '_status')
  int status;
  @JsonKey(name: '_data')
  List<DataListMyTicket> data;

  ListMyTicket({required this.status,required  this.data});
  factory ListMyTicket.fromJson(Map<String, dynamic> json) => _$ListMyTicketFromJson(json);
  Map<String, dynamic> toJson() => _$ListMyTicketToJson(this);
}