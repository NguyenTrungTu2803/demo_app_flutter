// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Extra _$ExtraFromJson(Map<String, dynamic> json) {
  return Extra(
    pagination: DataExtra.fromJson(json['_pagination'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExtraToJson(Extra instance) => <String, dynamic>{
      '_pagination': instance.pagination,
    };
