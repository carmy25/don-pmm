import 'fal_type.dart';

class FAL {
  FAL({required this.uuid, required this.falType, required this.amountLtrs})
      : weightKgs = amountLtrs * falType.density;
  final FALType falType;
  final double amountLtrs;
  final double weightKgs;
  final String uuid;

  @override
  bool operator ==(Object other) =>
      other is FAL && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
