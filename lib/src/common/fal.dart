enum FALCategory { diesel, petrol, oil, poison }

enum FALType {
  dpleuro5v0('ДП-л-Євро5 В0', 0.84, FALCategory.diesel),
  dpzeuro5v0('ДП-з-Євро5 В0', 0.85, FALCategory.diesel),
  a80('А-80', 0.75, FALCategory.petrol),
  adblue('AdBlue', 1.05, FALCategory.poison),
  m10g2k('М10г2к', 0.9, FALCategory.oil);

  const FALType(this.name, this.density, this.category);
  final String name;
  final FALCategory category;
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
