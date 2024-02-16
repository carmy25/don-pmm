class Car {
  const Car({required this.uuid, required this.name, required this.number});
  final String name, number, uuid;

  @override
  bool operator ==(Object other) =>
      other is Car && other.runtimeType == runtimeType && other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
