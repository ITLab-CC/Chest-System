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
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChestCopyWith<Chest> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChestCopyWith<$Res> {
  factory $ChestCopyWith(Chest value, $Res Function(Chest) then) =
      _$ChestCopyWithImpl<$Res, Chest>;
  @useResult
  $Res call({int id, String name});
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
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({int id, String name});
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
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$ChestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChestImpl with DiagnosticableTreeMixin implements _Chest {
  const _$ChestImpl({required this.id, required this.name});

  factory _$ChestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChestImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Chest(id: $id, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Chest'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

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
  const factory _Chest({required final int id, required final String name}) =
      _$ChestImpl;

  factory _Chest.fromJson(Map<String, dynamic> json) = _$ChestImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ChestImplCopyWith<_$ChestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
