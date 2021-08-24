import 'package:json_annotation/json_annotation.dart';
part 'check_in_model.g.dart';
@JsonSerializable()
class CheckInModel{
  @JsonKey(name: '_status')
  int status;

  CheckInModel(this.status);

  factory CheckInModel.fromJson(Map<String, dynamic> json) => _$CheckInModelFromJson(json);
  Map<String, dynamic> toJson() => _$CheckInModelToJson(this);
}