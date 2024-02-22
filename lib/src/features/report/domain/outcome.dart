class Outcome {
  const Outcome({required this.uuid, required this.name, required this.amount});
  final String uuid;
  final String name;
  final double amount;

  @override
  bool operator ==(Object other) =>
      other is Outcome &&
      other.runtimeType == runtimeType &&
      other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
