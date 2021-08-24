// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_tickets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataTickets _$DataTicketsFromJson(Map<String, dynamic> json) {
  return DataTickets(
    id: json['id'] as int,
    price: json['price'] as int,
    quantities: json['quantities'] as int,
    solvedTicket: json['solved_ticket'] as int,
    description: json['description'] as String,
    ticketType: json['ticket_type'] as String,
  );
}

Map<String, dynamic> _$DataTicketsToJson(DataTickets instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantities': instance.quantities,
      'solved_ticket': instance.solvedTicket,
      'description': instance.description,
      'ticket_type': instance.ticketType,
    };
