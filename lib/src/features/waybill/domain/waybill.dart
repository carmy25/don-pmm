class Waybill {
  const Waybill(
      {required this.uuid,
      required this.issueDate,
      required this.number,
      required this.carUuid,
      required this.kmsStart,
      required this.kmsEnd});
  final String number, uuid;
  final DateTime issueDate;
  final String carUuid;
  final double kmsStart, kmsEnd;

  @override
  bool operator ==(Object other) =>
      other is Waybill &&
      other.runtimeType == runtimeType &&
      other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
