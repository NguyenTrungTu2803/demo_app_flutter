import 'package:json_annotation/json_annotation.dart';
part 'data_ticket.g.dart';
@JsonSerializable()
class DataTicket{
  int id;
  int price;
  int quantities;
  @JsonKey(name: 'solved_ticket')
  int solvedTicket;
  String description;
  @JsonKey(name: 'ticket_type')
  String ticketType;
  @JsonKey(name: 'ticket_type_description')
  String ticketTypeDescription;
  @JsonKey(name: 'available_from')
  var availableFrom;
  @JsonKey(name: 'available_to')
  String availableTo;

  DataTicket({
    required this.id,
    required this.price,
    required this.quantities,
    required this.availableFrom,
    required  this.description,
    required  this.availableTo,
    required  this.solvedTicket,
    required  this.ticketType,
    required  this.ticketTypeDescription});
  factory DataTicket.fromJson(Map<String, dynamic> json) => _$DataTicketFromJson(json);
  Map<String, dynamic> toJson() => _$DataTicketToJson(this);
}