import 'package:json_annotation/json_annotation.dart';
part 'user_buy_ticket.g.dart';

@JsonSerializable()
class UserBuyTicket{
  int id;
  String name;
  String email;
  UserBuyTicket({required this.id, required this.name, required this.email});
  factory UserBuyTicket.fromJSon(Map<String, dynamic> json) => _$UserBuyTicketFromJson(json);
  Map<String, dynamic> toJson() => _$UserBuyTicketToJson(this);
}