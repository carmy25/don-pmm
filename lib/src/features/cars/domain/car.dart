class Car {
  const Car(
      {required this.uuid,
      required this.consumptionRate,
      required this.consumptionRateMH,
      required this.name,
      required this.number,
      required this.note});
  final String name, number, uuid;
  final double consumptionRate;
  final double consumptionRateMH;
  final String note;

  @override
  bool operator ==(Object other) =>
      other is Car && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
