class Waybill {
  const Waybill({
    required this.uuid,
    this.issueDate,
    required this.number,
    required this.carUuid,
    required this.kmsStart,
    required this.kmsEnd,
    required this.mhStart,
    required this.mhEnd,
  });
  final String number, uuid;
  final DateTime? issueDate;
  final String carUuid;
  final double kmsStart, kmsEnd;
  final double mhStart, mhEnd;

  @override
  bool operator ==(Object other) =>
      other is Waybill &&
      other.runtimeType == runtimeType &&
      other.uuid == uuid;

  @override
  int get hashCode => uuid.hashCode;
}
