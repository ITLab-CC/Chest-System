// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      id: json['id'] as int?,
      chests: (json['chests'] as List<dynamic>?)
          ?.map((e) => ChestQuantity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'id': instance.id,
      'chests': instance.chests,
    };

_$ChestQuantityImpl _$$ChestQuantityImplFromJson(Map<String, dynamic> json) =>
    _$ChestQuantityImpl(
      chestId: json['kiste_id'] as int,
      quantity: json['anzahl'] as int,
      chestName: json['kiste_name'] as String,
    );

Map<String, dynamic> _$$ChestQuantityImplToJson(_$ChestQuantityImpl instance) =>
    <String, dynamic>{
      'kiste_id': instance.chestId,
      'anzahl': instance.quantity,
      'kiste_name': instance.chestName,
    };
