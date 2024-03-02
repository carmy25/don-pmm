class Car {
  const Car(
      {required this.uuid,
      required this.consumptionRate,
      required this.name,
      required this.number});
  final String name, number, uuid;
  final double consumptionRate;

  @override
  bool operator ==(Object other) =>
      other is Car && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
