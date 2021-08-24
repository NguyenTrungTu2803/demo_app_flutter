// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagModel _$TagModelFromJson(Map<String, dynamic> json) {
  return TagModel(
    status: json['_status'] as int,
    dataTag: (json['_data'] as List<dynamic>)
        .map((e) => DataTag.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TagModelToJson(TagModel instance) => <String, dynamic>{
      '_status': instance.status,
      '_data': instance.dataTag,
    };
