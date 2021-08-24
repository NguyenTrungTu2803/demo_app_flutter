import 'package:json_annotation/json_annotation.dart';
part 'buy_ticket_model.g.dart';
@JsonSerializable()
class BuyTicketModel {
  @JsonKey(name: '_status')
  int status;

  BuyTicketModel({required this.status});
  factory BuyTicketModel.fromJson(Map<String, dynamic> json)=> _$BuyTicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuyTicketModelToJson(this);

}