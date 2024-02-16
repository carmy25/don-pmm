import '../../cars/domain/car.dart';

class Waybill {
  const Waybill({required this.uuid, required this.number, required this.car});
  final String number, uuid;
  final Car car;

  @override
  bool operator ==(Object other) =>
      other is Waybill &&
      other.runtimeType == runtimeType &&
      other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
