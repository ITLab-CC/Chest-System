// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chest _$ChestFromJson(Map<String, dynamic> json) {
  return _Chest.fromJson(json);
}

/// @nodoc
mixin _$Chest {
  String get name => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<ItemQuantitys>? get itemQuantitys => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChestCopyWith<Chest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChestCopyWith<$Res> {
  factory $ChestCopyWith(Chest value, $Res Function(Chest) then) =
      _$ChestCopyWithImpl<$Res, Chest>;
  @useResult
  $Res call(
      {String name,
      int? id,
      @JsonKey(name: 'items') List<ItemQuantitys>? itemQuantitys});
}

/// @nodoc
class _$ChestCopyWithImpl<$Res, $Val extends Chest>
    implements $ChestCopyWith<$Res> {
  _$ChestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? itemQuantitys = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      itemQuantitys: freezed == itemQuantitys
          ? _value.itemQuantitys
          : itemQuantitys // ignore: cast_nullable_to_non_nullable
              as List<ItemQuantitys>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChestImplCopyWith<$Res> implements $ChestCopyWith<$Res> {
  factory _$$ChestImplCopyWith(
          _$ChestImpl value, $Res Function(_$ChestImpl) then) =
      __$$ChestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int? id,
      @JsonKey(name: 'items') List<ItemQuantitys>? itemQuantitys});
}

/// @nodoc
class __$$ChestImplCopyWithImpl<$Res>
    extends _$ChestCopyWithImpl<$Res, _$ChestImpl>
    implements _$$ChestImplCopyWith<$Res> {
  __$$ChestImplCopyWithImpl(
      _$ChestImpl _value, $Res Function(_$ChestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = freezed,
    Object? itemQuantitys = freezed,
  }) {
    return _then(_$ChestImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      itemQuantitys: freezed == itemQuantitys
          ? _value._itemQuantitys
          : itemQuantitys // ignore: cast_nullable_to_non_nullable
              as List<ItemQuantitys>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChestImpl with DiagnosticableTreeMixin implements _Chest {
  const _$ChestImpl(
      {required this.name,
      this.id,
      @JsonKey(name: 'items') final List<ItemQuantitys>? itemQuantitys})
      : _itemQuantitys = itemQuantitys;

  factory _$ChestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChestImplFromJson(json);

  @override
  final String name;
  @override
  final int? id;
  final List<ItemQuantitys>? _itemQuantitys;
  @override
  @JsonKey(name: 'items')
  List<ItemQuantitys>? get itemQuantitys {
    final value = _itemQuantitys;
    if (value == null) return null;
    if (_itemQuantitys is EqualUnmodifiableListView) return _itemQuantitys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chest(name: $name, id: $id, itemQuantitys: $itemQuantitys)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chest'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('itemQuantitys', itemQuantitys));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._itemQuantitys, _itemQuantitys));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id,
      const DeepCollectionEquality().hash(_itemQuantitys));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChestImplCopyWith<_$ChestImpl> get copyWith =>
      __$$ChestImplCopyWithImpl<_$ChestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChestImplToJson(
      this,
    );
  }
}

abstract class _Chest implements Chest {
  const factory _Chest(
          {required final String name,
          final int? id,
          @JsonKey(name: 'items') final List<ItemQuantitys>? itemQuantitys}) =
      _$ChestImpl;

  factory _Chest.fromJson(Map<String, dynamic> json) = _$ChestImpl.fromJson;

  @override
  String get name;
  @override
  int? get id;
  @override
  @JsonKey(name: 'items')
  List<ItemQuantitys>? get itemQuantitys;
  @override
  @JsonKey(ignore: true)
  _$$ChestImplCopyWith<_$ChestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemQuantitys _$ItemQuantitysFromJson(Map<String, dynamic> json) {
  return _ItemQuantitys.fromJson(json);
}

/// @nodoc
mixin _$ItemQuantitys {
  @JsonKey(name: 'item_id')
  int get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'item_name')
  String get itemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'anzahl')
  int get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemQuantitysCopyWith<ItemQuantitys> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemQuantitysCopyWith<$Res> {
  factory $ItemQuantitysCopyWith(
          ItemQuantitys value, $Res Function(ItemQuantitys) then) =
      _$ItemQuantitysCopyWithImpl<$Res, ItemQuantitys>;
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') int itemId,
      @JsonKey(name: 'item_name') String itemName,
      @JsonKey(name: 'anzahl') int quantity});
}

/// @nodoc
class _$ItemQuantitysCopyWithImpl<$Res, $Val extends ItemQuantitys>
    implements $ItemQuantitysCopyWith<$Res> {
  _$ItemQuantitysCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? itemName = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemQuantitysImplCopyWith<$Res>
    implements $ItemQuantitysCopyWith<$Res> {
  factory _$$ItemQuantitysImplCopyWith(
          _$ItemQuantitysImpl value, $Res Function(_$ItemQuantitysImpl) then) =
      __$$ItemQuantitysImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') int itemId,
      @JsonKey(name: 'item_name') String itemName,
      @JsonKey(name: 'anzahl') int quantity});
}

/// @nodoc
class __$$ItemQuantitysImplCopyWithImpl<$Res>
    extends _$ItemQuantitysCopyWithImpl<$Res, _$ItemQuantitysImpl>
    implements _$$ItemQuantitysImplCopyWith<$Res> {
  __$$ItemQuantitysImplCopyWithImpl(
      _$ItemQuantitysImpl _value, $Res Function(_$ItemQuantitysImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? itemName = null,
    Object? quantity = null,
  }) {
    return _then(_$ItemQuantitysImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemQuantitysImpl
    with DiagnosticableTreeMixin
    implements _ItemQuantitys {
  const _$ItemQuantitysImpl(
      {@JsonKey(name: 'item_id') required this.itemId,
      @JsonKey(name: 'item_name') required this.itemName,
      @JsonKey(name: 'anzahl') required this.quantity});

  factory _$ItemQuantitysImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemQuantitysImplFromJson(json);

  @override
  @JsonKey(name: 'item_id')
  final int itemId;
  @override
  @JsonKey(name: 'item_name')
  final String itemName;
  @override
  @JsonKey(name: 'anzahl')
  final int quantity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ItemQuantitys(itemId: $itemId, itemName: $itemName, quantity: $quantity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ItemQuantitys'))
      ..add(DiagnosticsProperty('itemId', itemId))
      ..add(DiagnosticsProperty('itemName', itemName))
      ..add(DiagnosticsProperty('quantity', quantity));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemQuantitysImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, itemId, itemName, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemQuantitysImplCopyWith<_$ItemQuantitysImpl> get copyWith =>
      __$$ItemQuantitysImplCopyWithImpl<_$ItemQuantitysImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemQuantitysImplToJson(
      this,
    );
  }
}

abstract class _ItemQuantitys implements ItemQuantitys {
  const factory _ItemQuantitys(
          {@JsonKey(name: 'item_id') required final int itemId,
          @JsonKey(name: 'item_name') required final String itemName,
          @JsonKey(name: 'anzahl') required final int quantity}) =
      _$ItemQuantitysImpl;

  factory _ItemQuantitys.fromJson(Map<String, dynamic> json) =
      _$ItemQuantitysImpl.fromJson;

  @override
  @JsonKey(name: 'item_id')
  int get itemId;
  @override
  @JsonKey(name: 'item_name')
  String get itemName;
  @override
  @JsonKey(name: 'anzahl')
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$ItemQuantitysImplCopyWith<_$ItemQuantitysImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
