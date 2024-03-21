import 'package:donpmm/src/features/fal/domain/fal_type.dart';

import 'waybill.dart';

class Fillup {
  const Fillup(
      {required this.uuid,
      required this.falType,
      required this.date,
      required this.beforeLtrs,
      required this.fillupLtrs,
      required this.burnedLtrs,
      required this.waybill,
      required this.otherMilBase});
  final bool otherMilBase;
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
