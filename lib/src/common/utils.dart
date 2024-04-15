import 'dart:math';

import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_editable_table/entities/row_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
    1000000000: {'one': 'міліард', 'few': 'міліарда', 'many': 'міліардів'},
  };

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

  String? toWords(int number, {bool lowNumberInFemenineGender = false}) {
    if (number == 0) return _digitWords[number]?['male'];

    var words = [];
    var triades = splitToTriades(number);
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

      if (hundred > 0) triadeWords.add(_digitWords[hundred]!['male']);

      if (decimal > 0) triadeWords.add(_digitWords[decimal]!['male']);

      if (lowNumber > 0) {
        triadeWords.add(_digitWords[lowNumber]![lowNumberKindIdx] ??
            _digitWords[lowNumber]!['male']);
      }

      if (index > 0) {
        triadeWords.add(_digitWords[pow(10, 3 * index)]![countableIdx]);
      }

      words = triadeWords + words;
    });
    return words.join(' ');
  }

  int _hundredFromTriade(int triade) {
    return ((triade ~/ 100).truncate() * 100).toInt();
  }

  int _decimalFromTriade(int triade) {
    final decimal = triade - _hundredFromTriade(triade);
    return decimal < 20 ? 0 : ((decimal ~/ 10).truncate() * 10).toInt();
  }

  int _lowNumberFromTriade(int triade) {
    return triade - (_hundredFromTriade(triade) + _decimalFromTriade(triade));
  }
}

String? validateNotEmpty(value) {
  if (value == null || value.isEmpty) {
    return "Обов'язкове поле";
  }
  return null;
}

String? validateNotEmptyNumber(value) {
  final res = validateNotEmpty(value);
  if (res == null) {
    if (double.parse(value) > 0) {
      return null;
    } else {
      return 'Значення має бути більшим 0';
    }
  }
  return res;
}

String formatDateText(DateTime dt) {
  return DateFormat.yMMMMd('uk').format(dt);
}

String unitCorrectEnding(int num) {
  if (num > 20 || num < 5) {
    final rem = num > 20 ? num % 10 : num;
    if ([2, 3, 4].contains(rem)) {
      return 'штуки';
    }
    if (rem == 1) {
      return 'штука';
    }
  }
  return 'штук';
}

double parseDouble(String text) => text.isEmpty ? 0 : double.parse(text);

String formatDateToString(DateTime? date) {
  if (date == null) return '-';

  return DateFormat('dd.MM.yyyy').format(date);
}

double roundDouble(double value, {int places = 1}) {
  final mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

String removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}

void setFalTypeByName(String name, List<RowEntity> rows, WidgetRef ref) {
  final [falName, ...density] = name.split(':');
  final densityStr = density.isEmpty ? '' : density[0];
  double densityParsed = 0;
  try {
    densityParsed = double.parse(densityStr.trim());
  } catch (e) {
    debugPrint('Unable to parse: [$densityStr]');
  }
  final falType = ref.read(falTypeByNameAndDensityProvider(falName,
      density: densityStr.isEmpty ? null : densityParsed));
  if (falType == null) {
    return;
  }
  for (final row in rows) {
    final cells = row.cells!;
    if (cells[0].value == null &&
        cells[1].value == name &&
        cells[2].value == null) {
      cells[2].value = falType.density;
      cells[3].value = falType.category.name;
    }
  }
}
