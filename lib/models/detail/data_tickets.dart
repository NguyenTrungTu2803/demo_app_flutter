import 'package:json_annotation/json_annotation.dart';
part 'data_tickets.g.dart';
@JsonSerializable()
class DataTickets{
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'price')
  int price;
  @JsonKey(name: 'quantities')
  int quantities;
  @JsonKey(name: 'solved_ticket')
  int solvedTicket;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'ticket_type')
  String ticketType;

  DataTickets({required this.id,required  this.price, required this.quantities,required  this.solvedTicket,
    required this.description, required this.ticketType});
  factory DataTickets.fromJson(Map<String, dynamic> json) => _$DataTicketsFromJson(json);
  Map<String, dynamic> toJson() => _$DataTicketsToJson(this);
}