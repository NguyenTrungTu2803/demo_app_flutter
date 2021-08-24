import 'package:flutter_app_beats/models/my_ticket/data_event.dart';
import 'package:flutter_app_beats/models/my_ticket/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data_ticket.dart';
import 'string_qr.dart';
part 'data_list_my_ticket.g.dart';

@JsonSerializable()
class DataListMyTicket {
  int id;
  @JsonKey(name: 'ticket_id')
  int ticketId;
  @JsonKey(name: 'ticket')
  DataTicket dataTicket;
  @JsonKey(name: 'user_id')
  int userId;
  int quantities;
  @JsonKey(name: 'expired_at')
  String expiredAt;
  DataEvent event;
  @JsonKey(name: 'qr_string')
  List<StringQr> stringQr;
  User user;
  DataListMyTicket(
      {required this.id,
      required this.expiredAt,
      required this.dataTicket,
      required this.ticketId,
      required this.user,
      required this.quantities,
      required this.userId,
      required this.stringQr,
      required this.event});

  factory DataListMyTicket.fromJson(Map<String, dynamic> json) =>
      _$DataListMyTicketFromJson(json);
  Map<String, dynamic> toJson() => _$DataListMyTicketToJson(this);
}
