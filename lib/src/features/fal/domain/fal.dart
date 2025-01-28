import 'package:freezed_annotation/freezed_annotation.dart';

import 'fal_type.dart';

part 'fal.freezed.dart';

@Freezed(equal: false)
class FAL with _$FAL {
  const FAL._();
  const factory FAL(
      {required String uuid,
      required FALType falType,
      required double amountLtrs}) = _FAL;

  double get weightKgs => amountLtrs * falType.density;

  @override
  bool operator ==(Object other) =>
      other is FAL && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
