// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataPlace _$DataPlaceFromJson(Map<String, dynamic> json) {
  return DataPlace(
    address: json['address'] as String,
    slug: json['slug'] as String,
    lat: json['lat'] as String,
    long: json['long'] as String,
  );
}

Map<String, dynamic> _$DataPlaceToJson(DataPlace instance) => <String, dynamic>{
      'address': instance.address,
      'slug': instance.slug,
      'lat': instance.lat,
      'long': instance.long,
    };
