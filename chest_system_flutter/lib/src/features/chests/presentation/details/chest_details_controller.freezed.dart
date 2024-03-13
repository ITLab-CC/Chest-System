// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chest_details_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateChestItemQuantity {
  @JsonKey(name: 'item_id')
  int get itemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'anzahl')
  int get quantity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateChestItemQuantityCopyWith<CreateChestItemQuantity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChestItemQuantityCopyWith<$Res> {
  factory $CreateChestItemQuantityCopyWith(CreateChestItemQuantity value,
          $Res Function(CreateChestItemQuantity) then) =
      _$CreateChestItemQuantityCopyWithImpl<$Res, CreateChestItemQuantity>;
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') int itemId,
      @JsonKey(name: 'anzahl') int quantity});
}

/// @nodoc
class _$CreateChestItemQuantityCopyWithImpl<$Res,
        $Val extends CreateChestItemQuantity>
    implements $CreateChestItemQuantityCopyWith<$Res> {
  _$CreateChestItemQuantityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateChestItemQuantityImplCopyWith<$Res>
    implements $CreateChestItemQuantityCopyWith<$Res> {
  factory _$$CreateChestItemQuantityImplCopyWith(
          _$CreateChestItemQuantityImpl value,
          $Res Function(_$CreateChestItemQuantityImpl) then) =
      __$$CreateChestItemQuantityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'item_id') int itemId,
      @JsonKey(name: 'anzahl') int quantity});
}

/// @nodoc
class __$$CreateChestItemQuantityImplCopyWithImpl<$Res>
    extends _$CreateChestItemQuantityCopyWithImpl<$Res,
        _$CreateChestItemQuantityImpl>
    implements _$$CreateChestItemQuantityImplCopyWith<$Res> {
  __$$CreateChestItemQuantityImplCopyWithImpl(
      _$CreateChestItemQuantityImpl _value,
      $Res Function(_$CreateChestItemQuantityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? quantity = null,
  }) {
    return _then(_$CreateChestItemQuantityImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as int,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CreateChestItemQuantityImpl implements _CreateChestItemQuantity {
  const _$CreateChestItemQuantityImpl(
      {@JsonKey(name: 'item_id') required this.itemId,
      @JsonKey(name: 'anzahl') required this.quantity});

  @override
  @JsonKey(name: 'item_id')
  final int itemId;
  @override
  @JsonKey(name: 'anzahl')
  final int quantity;

  @override
  String toString() {
    return 'CreateChestItemQuantity(itemId: $itemId, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChestItemQuantityImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, itemId, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChestItemQuantityImplCopyWith<_$CreateChestItemQuantityImpl>
      get copyWith => __$$CreateChestItemQuantityImplCopyWithImpl<
          _$CreateChestItemQuantityImpl>(this, _$identity);
}

abstract class _CreateChestItemQuantity implements CreateChestItemQuantity {
  const factory _CreateChestItemQuantity(
          {@JsonKey(name: 'item_id') required final int itemId,
          @JsonKey(name: 'anzahl') required final int quantity}) =
      _$CreateChestItemQuantityImpl;

  @override
  @JsonKey(name: 'item_id')
  int get itemId;
  @override
  @JsonKey(name: 'anzahl')
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$CreateChestItemQuantityImplCopyWith<_$CreateChestItemQuantityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
