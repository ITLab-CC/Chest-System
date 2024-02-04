// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChestImpl _$$ChestImplFromJson(Map<String, dynamic> json) => _$ChestImpl(
      name: json['name'] as String,
      id: json['id'] as int?,
      itemQuantitys: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemQuantitys.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChestImplToJson(_$ChestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'items': instance.itemQuantitys,
    };

_$ItemQuantitysImpl _$$ItemQuantitysImplFromJson(Map<String, dynamic> json) =>
    _$ItemQuantitysImpl(
      itemId: json['item_id'] as int,
      itemName: json['item_name'] as String,
      quantity: json['anzahl'] as int,
    );

Map<String, dynamic> _$$ItemQuantitysImplToJson(_$ItemQuantitysImpl instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'item_name': instance.itemName,
      'anzahl': instance.quantity,
    };
