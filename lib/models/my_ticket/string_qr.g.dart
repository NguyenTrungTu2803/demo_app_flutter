// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'string_qr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StringQr _$StringQrFromJson(Map<String, dynamic> json) {
  return StringQr(
    qr: json['qr'] as String,
    checkInAt: json['checked_in_at'],
  );
}

Map<String, dynamic> _$StringQrToJson(StringQr instance) => <String, dynamic>{
      'qr': instance.qr,
      'checked_in_at': instance.checkInAt,
    };
