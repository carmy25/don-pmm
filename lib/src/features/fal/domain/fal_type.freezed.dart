// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fal_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FALType _$FALTypeFromJson(Map<String, dynamic> json) {
  return _FALType.fromJson(json);
}

/// @nodoc
mixin _$FALType {
  String get uuid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  FALCategory get category => throw _privateConstructorUsedError;
  double get density => throw _privateConstructorUsedError;

  /// Serializes this FALType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FALType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FALTypeCopyWith<FALType> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FALTypeCopyWith<$Res> {
  factory $FALTypeCopyWith(FALType value, $Res Function(FALType) then) =
      _$FALTypeCopyWithImpl<$Res, FALType>;
  @useResult
  $Res call({String uuid, String name, FALCategory category, double density});
}

/// @nodoc
class _$FALTypeCopyWithImpl<$Res, $Val extends FALType>
    implements $FALTypeCopyWith<$Res> {
  _$FALTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FALType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? category = null,
    Object? density = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as FALCategory,
      density: null == density
          ? _value.density
          : density // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FALTypeImplCopyWith<$Res> implements $FALTypeCopyWith<$Res> {
  factory _$$FALTypeImplCopyWith(
          _$FALTypeImpl value, $Res Function(_$FALTypeImpl) then) =
      __$$FALTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, String name, FALCategory category, double density});
}

/// @nodoc
class __$$FALTypeImplCopyWithImpl<$Res>
    extends _$FALTypeCopyWithImpl<$Res, _$FALTypeImpl>
    implements _$$FALTypeImplCopyWith<$Res> {
  __$$FALTypeImplCopyWithImpl(
      _$FALTypeImpl _value, $Res Function(_$FALTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of FALType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? name = null,
    Object? category = null,
    Object? density = null,
  }) {
    return _then(_$FALTypeImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as FALCategory,
      density: null == density
          ? _value.density
          : density // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FALTypeImpl implements _FALType {
  _$FALTypeImpl(
      {required this.uuid,
      required this.name,
      required this.category,
      required this.density});

  factory _$FALTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$FALTypeImplFromJson(json);

  @override
  final String uuid;
  @override
  final String name;
  @override
  final FALCategory category;
  @override
  final double density;

  @override
  String toString() {
    return 'FALType(uuid: $uuid, name: $name, category: $category, density: $density)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FALTypeImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.density, density) || other.density == density));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uuid, name, category, density);

  /// Create a copy of FALType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FALTypeImplCopyWith<_$FALTypeImpl> get copyWith =>
      __$$FALTypeImplCopyWithImpl<_$FALTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FALTypeImplToJson(
      this,
    );
  }
}

abstract class _FALType implements FALType {
  factory _FALType(
      {required final String uuid,
      required final String name,
      required final FALCategory category,
      required final double density}) = _$FALTypeImpl;

  factory _FALType.fromJson(Map<String, dynamic> json) = _$FALTypeImpl.fromJson;

  @override
  String get uuid;
  @override
  String get name;
  @override
  FALCategory get category;
  @override
  double get density;

  /// Create a copy of FALType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FALTypeImplCopyWith<_$FALTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
