import 'package:json_annotation/json_annotation.dart';
part 'string_qr.g.dart';
@JsonSerializable()
class StringQr {
  String qr;
  @JsonKey(name:'checked_in_at')
  var checkInAt;
  StringQr({required this.qr, required this.checkInAt});
  factory StringQr.fromJson(Map<String, dynamic> json) => _$StringQrFromJson(json);
  Map<String, dynamic> toJson() => _$StringQrToJson(this);
}