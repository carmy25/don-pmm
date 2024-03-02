import 'dart:math';

class NumericToWords {
  final _digitWords = {
    0: {'male': 'нуль'},
    1: {'male': 'один', 'female': 'одна'},
    2: {'male': 'два', 'female': 'дві'},
    3: {'male': 'три'},
    4: {'male': 'чoтири'},
    5: {'male': "п'ять"},
    6: {'male': 'шість'},
    7: {'male': 'сім'},
    8: {'male': 'вісім'},
    9: {'male': "дев'ять"},
    10: {'male': 'десять'},
    11: {'male': 'одинадцать'},
    12: {'male': 'дванадцать'},
    13: {'male': 'тринадцать'},
    14: {'male': 'чотирнадцать'},
    15: {'male': "п'ятнадцать"},
    16: {'male': 'шістнадцать'},
    17: {'male': 'сімнадцать'},
    18: {'male': 'вісімнадцать'},
    19: {'male': 'девятнадцать'},
    20: {'male': 'двадцать'},
    30: {'male': 'тридцать'},
    40: {'male': 'сорок'},
    50: {'male': "п'ятдесят"},
    60: {'male': 'шістдесят'},
    70: {'male': 'сімдесят'},
    80: {'male': 'вісімдесят'},
    90: {'male': 'девяносто'},
    100: {'male': 'сто'},
    200: {'male': 'двісті'},
    300: {'male': 'триста'},
    400: {'male': 'чотириста'},
    500: {'male': "п'ятсот"},
    600: {'male': 'шістсот'},
    700: {'male': 'сімсот'},
    800: {'male': 'вісімсот'},
    900: {'male': 'девятсот'},
    1000: {'one': 'тисяча', 'few': 'тисячі', 'many': 'тисяч'},
    1000000: {'one': 'мільйон', 'few': 'мільйона', 'many': 'мільйонов'},
    1000000000: {'one': 'миллиард', 'few': 'миллиарда', 'many': 'миллиардов'},
    1000000000000: {
      'one': 'триллион',
      'few': 'триллиона',
      'many': 'триллионов'
    },
  };

  /// Разбивает число на триады согласно разрядам
  List<String> splitToTriades(int number) {
    var strNumber = number.toString();
    var numberLength = strNumber.length;
    var triades = <String>[];
    var i = numberLength;
    do {
      var triade = strNumber.substring((i - 3 >= 0) ? i - 3 : 0, i);
      triades.add(triade);
      i -= 3;
    } while (i > 0);
    return List.from(triades.reversed);
  }

  int extractFraction(num number) {
    return int.parse(number.toStringAsFixed(2).split('.')[1]);
  }

  /// Преобразует число в строку прописью
  /// [number] - число для преобразования в строку прописью. Максимальное - 999 триллионов
  /// [lowNumberInFemenineGender] - если число заканчивается на 1,2, то оно будет преобразовано в строку в женском роде (одна, две)
  ///
  String? toWords(int number, {bool lowNumberInFemenineGender = false}) {
    if (number == 0) return _digitWords[number]?['male'];

    var words = [];
    var triades = splitToTriades(number);
    // Триады разрядов будем перебирать от меньших к большим (сотни, тысячи, миллионы, миллиарды)
    triades.reversed.toList().asMap().forEach((index, triade) {
      final intTriade = int.parse(triade);
      var triadeWords = [];
      final lowNumberKindIdx =
          (index == 1 || index == 0 && lowNumberInFemenineGender)
              ? 'female'
              : 'male';
      final hundred = _hundredFromTriade(intTriade);
      final decimal = _decimalFromTriade(intTriade);
      final lowNumber = _lowNumberFromTriade(intTriade);
      final countableIdx =
          lowNumber == 1 ? 'one' : (lowNumber < 5 ? 'few' : 'many');

      // Добавим в строку содержащую слова по текущей триаде сотни (сто, двести, ..., девятьсот)
      if (hundred > 0) triadeWords.add(_digitWords[hundred]!['male']);

      // Добавим в строку содержащую слова по текущей триаде десятки (десять, двадцать, ... девяносто)
      if (decimal > 0) triadeWords.add(_digitWords[decimal]!['male']);

      // Добавим в строку содержащую слова по текущей триаде числа (один, два, ... девятнадцать)
      if (lowNumber > 0) {
        triadeWords.add(_digitWords[lowNumber]![lowNumberKindIdx] ??
            _digitWords[lowNumber]!['male']);
      }

      // Добавим в строку содержащую слова по текущей триаде разряды (тысяча, миллион, ... миллиард)
      if (index > 0) {
        triadeWords.add(_digitWords[pow(10, 3 * index)]![countableIdx]);
      }

      // Поскольку перебираем триады от меньших разрядов к большим,
      // то получившиеся слова будем вставлять в начало строки, содержащей слова
      words = triadeWords + words;
    });
    return words.join(' ');
  }

  /// Извлекает сотни из триады(числа XXX)
  /// Например триада = 999, тогда результат будет: 9
  ///
  int _hundredFromTriade(int triade) {
    return ((triade ~/ 100).truncate() * 100).toInt();
  }

  /// Извлекает десятки из триады(числа XXX)
  /// Например триада = 999, тогда результат будет: 90
  /// Например триада = 911, тогда результат будет: 0
  ///
  int _decimalFromTriade(int triade) {
    final decimal = triade - _hundredFromTriade(triade);
    return decimal < 20 ? 0 : ((decimal ~/ 10).truncate() * 10).toInt();
  }

  /// Извлекает самый первый разряд из триады из триады(числа XXX)
  /// Например триада = 999, тогда результат будет: 9
  /// Например триада = 911, тогда результат будет: 11
  ///
  int _lowNumberFromTriade(int triade) {
    return triade - (_hundredFromTriade(triade) + _decimalFromTriade(triade));
  }
}
