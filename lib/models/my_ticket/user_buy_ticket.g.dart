// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_buy_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBuyTicket _$UserBuyTicketFromJson(Map<String, dynamic> json) {
  return UserBuyTicket(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserBuyTicketToJson(UserBuyTicket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
