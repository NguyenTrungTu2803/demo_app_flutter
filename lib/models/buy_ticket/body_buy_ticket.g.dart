// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_buy_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyBuyTicket _$BodyBuyTicketFromJson(Map<String, dynamic> json) {
  return BodyBuyTicket(
    ticketId: json['ticket_id'] as int,
    status: json['status'] as int,
    quantities: json['quantities'] as int,
  );
}

Map<String, dynamic> _$BodyBuyTicketToJson(BodyBuyTicket instance) =>
    <String, dynamic>{
      'ticket_id': instance.ticketId,
      'status': instance.status,
      'quantities': instance.quantities,
    };
