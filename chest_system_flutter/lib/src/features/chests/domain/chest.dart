import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chest.freezed.dart';
part 'chest.g.dart';

@freezed
class Chest with _$Chest {
  const factory Chest({
    required int id,
    required String name,
    // required String imageUrl,
  }) = _Chest;

  factory Chest.fromJson(Map<String, Object?> json) => _$ChestFromJson(json);
}

extension JsonWithoutId on Chest {
  String toJsonWithoutId() {
    final map = toJson();
    // ignore: cascade_invocations  //remove returns the removed field!, cascade_invocations
    map.remove('id');
    return json.encode(map);
  }
}

// String toJsonWithoutId(Chest p) {
//   var a = p.toJson();
//   var b = a.remove('id');
//   var c = json.encode(a);

//   // final map = p.toJson().remove('id');
//   // return json.encode(map);
//   return c;
// }
