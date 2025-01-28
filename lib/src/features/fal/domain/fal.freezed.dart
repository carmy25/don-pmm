// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FAL {
  String get uuid => throw _privateConstructorUsedError;
  FALType get falType => throw _privateConstructorUsedError;
  double get amountLtrs => throw _privateConstructorUsedError;

  /// Create a copy of FAL
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FALCopyWith<FAL> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FALCopyWith<$Res> {
  factory $FALCopyWith(FAL value, $Res Function(FAL) then) =
      _$FALCopyWithImpl<$Res, FAL>;
  @useResult
  $Res call({String uuid, FALType falType, double amountLtrs});

  $FALTypeCopyWith<$Res> get falType;
}

/// @nodoc
class _$FALCopyWithImpl<$Res, $Val extends FAL> implements $FALCopyWith<$Res> {
  _$FALCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FAL
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? falType = null,
    Object? amountLtrs = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      falType: null == falType
          ? _value.falType
          : falType // ignore: cast_nullable_to_non_nullable
              as FALType,
      amountLtrs: null == amountLtrs
          ? _value.amountLtrs
          : amountLtrs // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of FAL
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FALTypeCopyWith<$Res> get falType {
    return $FALTypeCopyWith<$Res>(_value.falType, (value) {
      return _then(_value.copyWith(falType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FALImplCopyWith<$Res> implements $FALCopyWith<$Res> {
  factory _$$FALImplCopyWith(_$FALImpl value, $Res Function(_$FALImpl) then) =
      __$$FALImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String uuid, FALType falType, double amountLtrs});

  @override
  $FALTypeCopyWith<$Res> get falType;
}

/// @nodoc
class __$$FALImplCopyWithImpl<$Res> extends _$FALCopyWithImpl<$Res, _$FALImpl>
    implements _$$FALImplCopyWith<$Res> {
  __$$FALImplCopyWithImpl(_$FALImpl _value, $Res Function(_$FALImpl) _then)
      : super(_value, _then);

  /// Create a copy of FAL
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? falType = null,
    Object? amountLtrs = null,
  }) {
    return _then(_$FALImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      falType: null == falType
          ? _value.falType
          : falType // ignore: cast_nullable_to_non_nullable
              as FALType,
      amountLtrs: null == amountLtrs
          ? _value.amountLtrs
          : amountLtrs // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$FALImpl extends _FAL {
  const _$FALImpl(
      {required this.uuid, required this.falType, required this.amountLtrs})
      : super._();

  @override
  final String uuid;
  @override
  final FALType falType;
  @override
  final double amountLtrs;

  @override
  String toString() {
    return 'FAL(uuid: $uuid, falType: $falType, amountLtrs: $amountLtrs)';
  }

  /// Create a copy of FAL
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FALImplCopyWith<_$FALImpl> get copyWith =>
      __$$FALImplCopyWithImpl<_$FALImpl>(this, _$identity);
}

abstract class _FAL extends FAL {
  const factory _FAL(
      {required final String uuid,
      required final FALType falType,
      required final double amountLtrs}) = _$FALImpl;
  const _FAL._() : super._();

  @override
  String get uuid;
  @override
  FALType get falType;
  @override
  double get amountLtrs;

  /// Create a copy of FAL
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FALImplCopyWith<_$FALImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
