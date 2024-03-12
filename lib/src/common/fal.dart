enum FALCategory { diesel, petrol, oil, poison }

enum FALType {
  d1('ДП-Арк-Євро5 В0', 0.85, FALCategory.diesel),
  d2('ДП-з-Євро5 В0', 0.85, FALCategory.diesel),
  d3('ДП-з-Євро-5 В0(ДТ-Е-К5 сорт Е)', 0.85, FALCategory.diesel),
  d4('ДП(МТД)', 0.85, FALCategory.diesel),
  d5('ПД ДП Арк Євро5 В0', 0.85, FALCategory.diesel),
  d6('Energy ДП-л Євро5 В0', 0.84, FALCategory.diesel),
  d7('ДП-л-К5 сорт С', 0.84, FALCategory.diesel),
  d8('ДП-л-Євро 5 В0', 0.84, FALCategory.diesel),
  d9('ДП-з-Євро5 В0(ULSD 10PPM)', 0.85, FALCategory.diesel),
  d10('ДП Energy ДП-л-Євро5 В0', 0.84, FALCategory.diesel),
  p1('А-92 Євро5 Е0', 0.75, FALCategory.petrol),
  p2('А-80 ДЗ', 0.75, FALCategory.petrol),
  p3('А-95 Євро5 Е5', 0.75, FALCategory.petrol),
  o1('Evinrude Johnson XD-100', 0.9, FALCategory.oil),
  o2('SAE 5W40 CI-4/SL', 0.9, FALCategory.oil),
  o3('Азмол Гарант M-4042 ВТ', 0.9, FALCategory.oil),
  o4('Протек MD+ 15W40', 0.9, FALCategory.oil),
  o5('Літол-24', 0.9, FALCategory.oil),
  o6('JASOL Truck Premium SHPD CI-4/SL 15W40', 0.9, FALCategory.oil),
  o7('JASOL Truck Ultra UHPD CI-4/SL', 0.9, FALCategory.oil),
  o8('Олива РЖ', 0.9, FALCategory.oil),
  o9('ТСп-15К', 0.9, FALCategory.oil),
  o10('OLF CARTER EXTRA SYNT 75w90', 0.9, FALCategory.oil),
  o11('Замазка ЗЗК-3у', 0.9, FALCategory.oil),
  o12('Олива гідравлічна марки "А"', 0.9, FALCategory.oil),
  o13('Олива ATF III(ATF-300)', 0.9, FALCategory.oil),
  o14('Prista 15W40 API CI-4/SL', 0.9, FALCategory.oil),
  o15('YUKO ATF III', 0.9, FALCategory.oil),
  o16('YUKO ATF VI HD', 0.9, FALCategory.oil),
  o17('Prista ATF III', 0.9, FALCategory.oil),
  o18('80W90(EXTENDTECH 80W90 GL)', 0.9, FALCategory.oil),
  o19('80W90 GL-5', 0.9, FALCategory.oil),
  o20('Аріан Trans H 80W-90GI-5', 0.9, FALCategory.oil),
  o21('М10Г2К', 0.9, FALCategory.oil),
  o22('М6з10в', 0.9, FALCategory.oil),
  o23('Нефрас С2-80/120', 0.9, FALCategory.oil),
  o24('Transmission Gold SAE 80W90 API GL 5', 0.9, FALCategory.oil),
  o25('Олива АУ', 0.9, FALCategory.oil),
  o26('Олива Аргінол АУ', 0.9, FALCategory.oil),
  o27('Олива Р', 0.9, FALCategory.oil),
  o28('ГОІ-54п', 0.9, FALCategory.oil),
  o29('VipOilProfessional TDI 10w40 CI-4/SL', 0.9, FALCategory.oil),
  o30('Prista SHPD VDS-3 15W40', 0.9, FALCategory.oil),
  o31('Prista SHPD VDS-3 10W40 CI-4/SL', 0.9, FALCategory.oil),
  o32('SAE 15W40 API CH-4|SJ O-236', 0.9, FALCategory.oil),
  o33('МТ-16п(Prista MT-16P)', 0.9, FALCategory.oil),
  o34('Мастило ГРАФІТНЕ', 0.9, FALCategory.oil),
  o35('Протек SD 5w40 API CI-4/SL', 0.9, FALCategory.oil),
  o36('ТАП-15В', 0.9, FALCategory.oil),
  o37('Orien Oil H-515', 0.9, FALCategory.oil),
  o38('Arian Disel Super SAE 10w40 Cl-4/SL(МОУ)', 0.9, FALCategory.oil),
  o39('TITAN LHM+', 0.9, FALCategory.oil),
  o40('ДД М-14Г2пс', 0.9, FALCategory.oil),
  o41('Fuchs TITAN Marine TC W-3', 0.9, FALCategory.oil),
  ps1('Рідина охолоджувальна М-40', 1.1, FALCategory.poison),
  ps2('Рідина охолоджувальна АІ-39', 1.1, FALCategory.poison),
  ps3('TEMOL Tosol A-40', 1.1, FALCategory.poison),
  ps4('ПРОТЕК Tosol A-40', 1.1, FALCategory.poison),
  ps5('Рідина охолоджувальна ОЖ-40', 1.1, FALCategory.poison),
  ps6('STARFIRE ETHYLENE GLYCOL 60%', 1.1, FALCategory.poison),
  ps7('Гальмівна рідина DOT 4 B000750', 1.1, FALCategory.poison),
  ps8('JASOL EXTENDED LIFE-37G12+200L', 1.1, FALCategory.poison),
  ps9('JASOL EXTENDED LIFE-37G12', 1.1, FALCategory.poison),
  ps10('JASOL DOT-4', 1.1, FALCategory.poison),
  ps11('PRISTA DOT-5', 1.1, FALCategory.poison),
  ps12('AdBlue', 1.05, FALCategory.poison),
  ps13('Prista AdBlue', 1.05, FALCategory.poison),
  ps14('Тосол-40', 1.1, FALCategory.poison),
  ps15('Протек Antifreeze G-11', 1.1, FALCategory.poison),
  ps16('G-12', 1.1, FALCategory.poison),
  ps17('Fuchs AL-39(S-757) C', 1.1, FALCategory.poison),
  ps18('FRN Santinel SenSyn 46170', 1.1, FALCategory.poison);

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
