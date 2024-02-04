import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  const factory Item({
    required String name,
    required String description,
    int? id,
    // required String imageUrl,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}

extension JsonWithoutId on Item {
  String toJsonWithoutId() {
    final map = toJson();
    // ignore: cascade_invocations  //remove returns the removed field!, cascade_invocations
    map.remove('id');
    return json.encode(map);
  }
}

// String toJsonWithoutId(Item p) {
//   var a = p.toJson();
//   var b = a.remove('id');
//   var c = json.encode(a);

//   // final map = p.toJson().remove('id');
//   // return json.encode(map);
//   return c;
// }
