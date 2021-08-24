// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataTicket _$DataTicketFromJson(Map<String, dynamic> json) {
  return DataTicket(
    id: json['id'] as int,
    price: json['price'] as int,
    quantities: json['quantities'] as int,
    availableFrom: json['available_from'],
    description: json['description'] as String,
    availableTo: json['available_to'] as String,
    solvedTicket: json['solved_ticket'] as int,
    ticketType: json['ticket_type'] as String,
    ticketTypeDescription: json['ticket_type_description'] as String,
  );
}

Map<String, dynamic> _$DataTicketToJson(DataTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'quantities': instance.quantities,
      'solved_ticket': instance.solvedTicket,
      'description': instance.description,
      'ticket_type': instance.ticketType,
      'ticket_type_description': instance.ticketTypeDescription,
      'available_from': instance.availableFrom,
      'available_to': instance.availableTo,
    };
