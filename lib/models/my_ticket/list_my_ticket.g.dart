// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_my_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListMyTicket _$ListMyTicketFromJson(Map<String, dynamic> json) {
  return ListMyTicket(
    status: json['_status'] as int,
    data: (json['_data'] as List<dynamic>)
        .map((e) => DataListMyTicket.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListMyTicketToJson(ListMyTicket instance) =>
    <String, dynamic>{
      '_status': instance.status,
      '_data': instance.data,
    };
