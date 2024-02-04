// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  List<ChestQuantity>? get chests => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String name, String description, int? id, List<ChestQuantity>? chests});
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? id = freezed,
    Object? chests = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      chests: freezed == chests
          ? _value.chests
          : chests // ignore: cast_nullable_to_non_nullable
              as List<ChestQuantity>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String description, int? id, List<ChestQuantity>? chests});
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? id = freezed,
    Object? chests = freezed,
  }) {
    return _then(_$ItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      chests: freezed == chests
          ? _value._chests
          : chests // ignore: cast_nullable_to_non_nullable
              as List<ChestQuantity>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl with DiagnosticableTreeMixin implements _Item {
  const _$ItemImpl(
      {required this.name,
      required this.description,
      this.id,
      final List<ChestQuantity>? chests})
      : _chests = chests;

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final int? id;
  final List<ChestQuantity>? _chests;
  @override
  List<ChestQuantity>? get chests {
    final value = _chests;
    if (value == null) return null;
    if (_chests is EqualUnmodifiableListView) return _chests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Item(name: $name, description: $description, id: $id, chests: $chests)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Item'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('chests', chests));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._chests, _chests));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, id,
      const DeepCollectionEquality().hash(_chests));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {required final String name,
      required final String description,
      final int? id,
      final List<ChestQuantity>? chests}) = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  int? get id;
  @override
  List<ChestQuantity>? get chests;
  @override
  @JsonKey(ignore: true)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChestQuantity _$ChestQuantityFromJson(Map<String, dynamic> json) {
  return _ChestQuantity.fromJson(json);
}

/// @nodoc
mixin _$ChestQuantity {
  @JsonKey(name: 'kiste_id')
  int get chestId => throw _privateConstructorUsedError;
  @JsonKey(name: 'anzahl')
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'kiste_name')
  String get chestName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChestQuantityCopyWith<ChestQuantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChestQuantityCopyWith<$Res> {
  factory $ChestQuantityCopyWith(
          ChestQuantity value, $Res Function(ChestQuantity) then) =
      _$ChestQuantityCopyWithImpl<$Res, ChestQuantity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'kiste_id') int chestId,
      @JsonKey(name: 'anzahl') int quantity,
      @JsonKey(name: 'kiste_name') String chestName});
}

/// @nodoc
class _$ChestQuantityCopyWithImpl<$Res, $Val extends ChestQuantity>
    implements $ChestQuantityCopyWith<$Res> {
  _$ChestQuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chestId = null,
    Object? quantity = null,
    Object? chestName = null,
  }) {
    return _then(_value.copyWith(
      chestId: null == chestId
          ? _value.chestId
          : chestId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      chestName: null == chestName
          ? _value.chestName
          : chestName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChestQuantityImplCopyWith<$Res>
    implements $ChestQuantityCopyWith<$Res> {
  factory _$$ChestQuantityImplCopyWith(
          _$ChestQuantityImpl value, $Res Function(_$ChestQuantityImpl) then) =
      __$$ChestQuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'kiste_id') int chestId,
      @JsonKey(name: 'anzahl') int quantity,
      @JsonKey(name: 'kiste_name') String chestName});
}

/// @nodoc
class __$$ChestQuantityImplCopyWithImpl<$Res>
    extends _$ChestQuantityCopyWithImpl<$Res, _$ChestQuantityImpl>
    implements _$$ChestQuantityImplCopyWith<$Res> {
  __$$ChestQuantityImplCopyWithImpl(
      _$ChestQuantityImpl _value, $Res Function(_$ChestQuantityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chestId = null,
    Object? quantity = null,
    Object? chestName = null,
  }) {
    return _then(_$ChestQuantityImpl(
      chestId: null == chestId
          ? _value.chestId
          : chestId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      chestName: null == chestName
          ? _value.chestName
          : chestName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChestQuantityImpl
    with DiagnosticableTreeMixin
    implements _ChestQuantity {
  const _$ChestQuantityImpl(
      {@JsonKey(name: 'kiste_id') required this.chestId,
      @JsonKey(name: 'anzahl') required this.quantity,
      @JsonKey(name: 'kiste_name') required this.chestName});

  factory _$ChestQuantityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChestQuantityImplFromJson(json);

  @override
  @JsonKey(name: 'kiste_id')
  final int chestId;
  @override
  @JsonKey(name: 'anzahl')
  final int quantity;
  @override
  @JsonKey(name: 'kiste_name')
  final String chestName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChestQuantity(chestId: $chestId, quantity: $quantity, chestName: $chestName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChestQuantity'))
      ..add(DiagnosticsProperty('chestId', chestId))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('chestName', chestName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChestQuantityImpl &&
            (identical(other.chestId, chestId) || other.chestId == chestId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.chestName, chestName) ||
                other.chestName == chestName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chestId, quantity, chestName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChestQuantityImplCopyWith<_$ChestQuantityImpl> get copyWith =>
      __$$ChestQuantityImplCopyWithImpl<_$ChestQuantityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChestQuantityImplToJson(
      this,
    );
  }
}

abstract class _ChestQuantity implements ChestQuantity {
  const factory _ChestQuantity(
          {@JsonKey(name: 'kiste_id') required final int chestId,
          @JsonKey(name: 'anzahl') required final int quantity,
          @JsonKey(name: 'kiste_name') required final String chestName}) =
      _$ChestQuantityImpl;

  factory _ChestQuantity.fromJson(Map<String, dynamic> json) =
      _$ChestQuantityImpl.fromJson;

  @override
  @JsonKey(name: 'kiste_id')
  int get chestId;
  @override
  @JsonKey(name: 'anzahl')
  int get quantity;
  @override
  @JsonKey(name: 'kiste_name')
  String get chestName;
  @override
  @JsonKey(ignore: true)
  _$$ChestQuantityImplCopyWith<_$ChestQuantityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
