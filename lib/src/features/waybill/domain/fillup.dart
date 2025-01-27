import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';

part 'fillup.freezed.dart';

@Freezed(equal: false)
class Fillup with _$Fillup {
  const Fillup._();
  const factory Fillup(
      {required String uuid,
      required FALType falType,
      required double beforeLtrs,
      required double fillupLtrs,
      required double burnedLtrs,
      required String waybill,
      required bool otherMilBase}) = _Fillup;

  @override
  bool operator ==(Object other) =>
      other is Fillup && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
