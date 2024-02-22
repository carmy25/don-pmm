enum FALType {
  dpleuro5v0('ДП-л-Євро5 В0', 0.84),
  dpzeuro5v0('ДП-з-Євро5 В0', 0.85),
  a80('А-80', 0.75);

  const FALType(this.name, this.density);
  final String name;
  final double density;
}

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
