// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'car.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Car {
  String get uuid => throw _privateConstructorUsedError;
  double get consumptionRate => throw _privateConstructorUsedError;
  double get consumptionRateMH => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;
  bool get underRepair => throw _privateConstructorUsedError;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarCopyWith<Car> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarCopyWith<$Res> {
  factory $CarCopyWith(Car value, $Res Function(Car) then) =
      _$CarCopyWithImpl<$Res, Car>;
  @useResult
  $Res call(
      {String uuid,
      double consumptionRate,
      double consumptionRateMH,
      String name,
      String number,
      String note,
      bool underRepair});
}

/// @nodoc
class _$CarCopyWithImpl<$Res, $Val extends Car> implements $CarCopyWith<$Res> {
  _$CarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? consumptionRate = null,
    Object? consumptionRateMH = null,
    Object? name = null,
    Object? number = null,
    Object? note = null,
    Object? underRepair = null,
  }) {
    return _then(_value.copyWith(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      consumptionRate: null == consumptionRate
          ? _value.consumptionRate
          : consumptionRate // ignore: cast_nullable_to_non_nullable
              as double,
      consumptionRateMH: null == consumptionRateMH
          ? _value.consumptionRateMH
          : consumptionRateMH // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      underRepair: null == underRepair
          ? _value.underRepair
          : underRepair // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CarImplCopyWith<$Res> implements $CarCopyWith<$Res> {
  factory _$$CarImplCopyWith(_$CarImpl value, $Res Function(_$CarImpl) then) =
      __$$CarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uuid,
      double consumptionRate,
      double consumptionRateMH,
      String name,
      String number,
      String note,
      bool underRepair});
}

/// @nodoc
class __$$CarImplCopyWithImpl<$Res> extends _$CarCopyWithImpl<$Res, _$CarImpl>
    implements _$$CarImplCopyWith<$Res> {
  __$$CarImplCopyWithImpl(_$CarImpl _value, $Res Function(_$CarImpl) _then)
      : super(_value, _then);

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = null,
    Object? consumptionRate = null,
    Object? consumptionRateMH = null,
    Object? name = null,
    Object? number = null,
    Object? note = null,
    Object? underRepair = null,
  }) {
    return _then(_$CarImpl(
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      consumptionRate: null == consumptionRate
          ? _value.consumptionRate
          : consumptionRate // ignore: cast_nullable_to_non_nullable
              as double,
      consumptionRateMH: null == consumptionRateMH
          ? _value.consumptionRateMH
          : consumptionRateMH // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      note: null == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
      underRepair: null == underRepair
          ? _value.underRepair
          : underRepair // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CarImpl extends _Car with DiagnosticableTreeMixin {
  const _$CarImpl(
      {required this.uuid,
      required this.consumptionRate,
      required this.consumptionRateMH,
      required this.name,
      required this.number,
      required this.note,
      required this.underRepair})
      : super._();

  @override
  final String uuid;
  @override
  final double consumptionRate;
  @override
  final double consumptionRateMH;
  @override
  final String name;
  @override
  final String number;
  @override
  final String note;
  @override
  final bool underRepair;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Car(uuid: $uuid, consumptionRate: $consumptionRate, consumptionRateMH: $consumptionRateMH, name: $name, number: $number, note: $note, underRepair: $underRepair)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Car'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('consumptionRate', consumptionRate))
      ..add(DiagnosticsProperty('consumptionRateMH', consumptionRateMH))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('note', note))
      ..add(DiagnosticsProperty('underRepair', underRepair));
  }

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarImplCopyWith<_$CarImpl> get copyWith =>
      __$$CarImplCopyWithImpl<_$CarImpl>(this, _$identity);
}

abstract class _Car extends Car {
  const factory _Car(
      {required final String uuid,
      required final double consumptionRate,
      required final double consumptionRateMH,
      required final String name,
      required final String number,
      required final String note,
      required final bool underRepair}) = _$CarImpl;
  const _Car._() : super._();

  @override
  String get uuid;
  @override
  double get consumptionRate;
  @override
  double get consumptionRateMH;
  @override
  String get name;
  @override
  String get number;
  @override
  String get note;
  @override
  bool get underRepair;

  /// Create a copy of Car
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarImplCopyWith<_$CarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
