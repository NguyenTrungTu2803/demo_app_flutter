// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list_my_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataListMyTicket _$DataListMyTicketFromJson(Map<String, dynamic> json) {
  return DataListMyTicket(
    id: json['id'] as int,
    expiredAt: json['expired_at'] as String,
    dataTicket: DataTicket.fromJson(json['ticket'] as Map<String, dynamic>),
    ticketId: json['ticket_id'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    quantities: json['quantities'] as int,
    userId: json['user_id'] as int,
    stringQr: (json['qr_string'] as List<dynamic>)
        .map((e) => StringQr.fromJson(e as Map<String, dynamic>))
        .toList(),
    event: DataEvent.fromJson(json['event'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataListMyTicketToJson(DataListMyTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket_id': instance.ticketId,
      'ticket': instance.dataTicket,
      'user_id': instance.userId,
      'quantities': instance.quantities,
      'expired_at': instance.expiredAt,
      'event': instance.event,
      'qr_string': instance.stringQr,
      'user': instance.user,
    };
