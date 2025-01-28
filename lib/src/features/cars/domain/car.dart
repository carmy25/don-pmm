import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'car.freezed.dart';

@Freezed(equal: false)
class Car with _$Car {
  const Car._();
  const factory Car(
      {required String uuid,
      required double consumptionRate,
      required double consumptionRateMH,
      required String name,
      required String number,
      required String note,
      required bool underRepair}) = _Car;

  @override
  bool operator ==(Object other) =>
      other is Car &&
      other.runtimeType == other.runtimeType &&
      other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
