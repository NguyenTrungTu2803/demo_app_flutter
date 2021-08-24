import 'package:json_annotation/json_annotation.dart';

part 'body_buy_ticket.g.dart';
@JsonSerializable()
class BodyBuyTicket{
  @JsonKey(name:'ticket_id')
  int ticketId;
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'quantities')
  int quantities;

  BodyBuyTicket({required this.ticketId,required this.status,required this.quantities});
  factory BodyBuyTicket.fromJson(Map<String, dynamic> json)=> _$BodyBuyTicketFromJson(json);
  Map<String, dynamic> toJson() => _$BodyBuyTicketToJson(this);
}