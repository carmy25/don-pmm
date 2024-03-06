enum CarType {
  vehicle('Машина'),
  workingUnit('Робочий агрегат');

  const CarType(this.name);
  final String name;
}

class Car {
  const Car(
      {required this.uuid,
      required this.consumptionRate,
      required this.name,
      required this.number,
      required this.type,
      required this.note});
  final String name, number, uuid;
  final double consumptionRate;
  final CarType type;
  final String note;

  @override
  bool operator ==(Object other) =>
      other is Car && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
