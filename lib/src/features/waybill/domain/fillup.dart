import 'package:donpmm/src/common/fal.dart';

import 'waybill.dart';

class Fillup {
  const Fillup(
      {required this.uuid,
      required this.falType,
      required this.date,
      required this.beforeLtrs,
      required this.fillupLtrs,
      required this.burnedLtrs,
      required this.waybill});
  final FALType falType;
  final DateTime date;
  final String uuid;
  final Waybill waybill;
  final double beforeLtrs, fillupLtrs, burnedLtrs;

  @override
  bool operator ==(Object other) =>
      other is Fillup && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
