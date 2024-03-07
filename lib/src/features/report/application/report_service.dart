import 'dart:io';
import 'package:collection/collection.dart';
import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/cars/data/cars_repository.dart';
import 'package:donpmm/src/features/cars/domain/car.dart';
import 'package:donpmm/src/features/report/data/outcomes_repository.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/data/waybills_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;

part 'report_service.g.dart';

class ReportService {
  final Ref ref;
  final workbook = Workbook();
  late final Style _tableStyle;
  late final Style _reportCellStyle;
  late final Style _reportHeaderStyle;

  ReportService({required this.ref}) {
    _tableStyle = workbook.styles.add('style');
    _tableStyle.borders.all.lineStyle = LineStyle.thin;
    _tableStyle.hAlign = HAlignType.center;
    _tableStyle.vAlign = VAlignType.center;
    _tableStyle.fontSize = 10;
    _tableStyle.wrapText = true;

    _reportCellStyle = workbook.styles.add('reportHeader1Style');
    _reportCellStyle.borders.all.lineStyle = LineStyle.thin;
    _reportCellStyle.hAlign = HAlignType.center;
    _reportCellStyle.vAlign = VAlignType.center;
    _reportCellStyle.fontSize = 10;
    _reportCellStyle.wrapText = true;

    _reportHeaderStyle = workbook.styles.add('reportHeaderStyle');
    _reportHeaderStyle.borders.all.lineStyle = LineStyle.thin;
    _reportHeaderStyle.hAlign = HAlignType.center;
    _reportHeaderStyle.vAlign = VAlignType.center;
    _reportHeaderStyle.fontSize = 10;
    _reportHeaderStyle.wrapText = true;
    _reportHeaderStyle.rotation = 90;
  }

  saveToFile(String path) async {
    _generateRegistrySheet(workbook.worksheets.addWithName('Реєстр'));
    _generateReportingSheet(workbook.worksheets.addWithName('Донесення'));
    _generateTranscriptSheet(workbook.worksheets.addWithName('Розшифровка'));
    _generateInfoSheet(
        workbook.worksheets.addWithName('Відомість АБ'), FALCategory.petrol);
    _generateInfoSheet(
        workbook.worksheets.addWithName('Відомість ДП'), FALCategory.diesel);
    _generateWaybillsRegistrySheet(
        workbook.worksheets.addWithName('Реєстр шляхових листів'));

    List<int> bytes = workbook.saveSync();
    await File(path).writeAsBytes(bytes);
    workbook.dispose();
  }

  void _generateWaybillsRegistrySheet(Worksheet sheet) {
    final report = ref.read(reportRepositoryProvider).value!;
    _updateDataCell(sheet, 'a1:n1', 'Реєстр шляхових листів').merge();
    _updateDataCell(sheet, 'a2:b2', 'Шляховий лист').merge();
    _updateDataCell(sheet, 'c2:d2', 'Показання').merge();

    var c = sheet.getRangeByName('E2:E3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Пройдено (км)';

    c = sheet.getRangeByName('f2:f3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Відпрацьованно (м/г)';

    _updateDataCell(sheet, 'g2:h2', 'Норма витрати').merge();

    c = sheet.getRangeByName('i2:i3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Залишок';

    c = sheet.getRangeByName('j2:j3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Видано по р/в';

    c = sheet.getRangeByName('k2:k3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Списано за шл./л.';

    c = sheet.getRangeByName('l2:l3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Залишок';

    c = sheet.getRangeByName('m2:m3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Перенесенно, л';

    c = sheet.getRangeByName('m2:m3');
    c.merge();
    c.cellStyle = _reportHeaderStyle;
    c.text = '№';

    _updateDataCell(sheet, 'a3', '№').rowHeight = 25;
    _updateDataCell(sheet, 'b3', 'Дата');
    _updateDataCell(sheet, 'c3', 'Перед виїздом');
    _updateDataCell(sheet, 'd3', 'Після виїзду');
    _updateDataCell(sheet, 'g3', 'На 100 км');
    _updateDataCell(sheet, 'h3', 'На 1 м/г');

    _updateDataCell(sheet, 'a4:n4', '').merge();

    var cidx = _waybillsRegistryAddTableCells(sheet);
    cidx += 2;
    c = sheet.getRangeByName('b$cidx:e$cidx');
    c.merge();
    c.cellStyle.fontSize = 10;
    c.text = 'Донесення №________________';

    c = sheet.getRangeByName('g$cidx:n$cidx');
    c.merge();
    c.cellStyle.fontSize = 10;
    c.text =
        '${report.chiefPosition} ${report.unitName} ${report.chiefRank}              ${report.chiefName}';
  }

  int _waybillsRegistryAddTableCells(Worksheet sheet) {
    final waybills = ref.read(waybillListProvider).value!;
    var cidx = 4;
    for (final waybill in waybills) {
      ++cidx;
      final car = ref.read(carByUuidProvider(waybill.carUuid));
      _updateDataCell(sheet, 'A$cidx', waybill.number);
      _updateDataCell(
          sheet, 'B$cidx', DateFormat("dd.MM.yyyy").format(waybill.issueDate!));
      _updateDataCell(sheet, 'C$cidx', waybill.kmsStart.toString());
      _updateDataCell(sheet, 'D$cidx', waybill.kmsEnd.toString());
      _updateDataCell(sheet, '${car.type == CarType.vehicle ? "E" : "F"}$cidx',
          (waybill.kmsEnd - waybill.kmsStart).toString(),
          isNumber: true);
      _updateDataCell(sheet, '${car.type == CarType.vehicle ? "G" : "H"}$cidx',
          car.consumptionRate.toString(),
          isNumber: true);

      final fillups = ref.read(fillupsByWaybillProvider(waybill));
      var bsum = fillups
          .where(
            (f) => f.falType.category == FALCategory.diesel,
          )
          .map((f) => f.beforeLtrs)
          .sum;
      if (bsum == 0) {
        bsum = fillups
            .where(
              (f) => f.falType.category == FALCategory.petrol,
            )
            .map((f) => f.beforeLtrs)
            .sum;
      }

      _updateDataCell(sheet, 'I$cidx', bsum.toString(), isNumber: true);

      var fsum = fillups
          .where(
            (f) => f.falType.category == FALCategory.diesel,
          )
          .map((f) => f.fillupLtrs)
          .sum;
      if (fsum == 0) {
        fsum = fillups
            .where(
              (f) => f.falType.category == FALCategory.petrol,
            )
            .map((f) => f.fillupLtrs)
            .sum;
      }

      _updateDataCell(sheet, 'j$cidx', fsum.toString(), isNumber: true);

      var ssum = fillups
          .where(
            (f) => f.falType.category == FALCategory.diesel,
          )
          .map((f) => f.burnedLtrs)
          .sum;
      if (ssum == 0) {
        ssum = fillups
            .where(
              (f) => f.falType.category == FALCategory.petrol,
            )
            .map((f) => f.burnedLtrs)
            .sum;
      }

      _updateDataCell(sheet, 'k$cidx', ssum.toString(), isNumber: true);
      _updateDataCell(sheet, 'l$cidx', (fsum + bsum - ssum).toString(),
          isNumber: true);
      _updateDataCell(sheet, 'm$cidx', '');
      _updateDataCell(sheet, 'n$cidx', '');
    }
    ++cidx;
    _updateDataCell(sheet, 'a$cidx:d$cidx', 'РАЗОМ').merge();
    _updateDataCellFormula(sheet, 'e$cidx', '=sum(e5:e${cidx - 1})');
    _updateDataCellFormula(sheet, 'f$cidx', '=sum(f5:f${cidx - 1})');
    _updateDataCellFormula(sheet, 'j$cidx', '=sum(j5:j${cidx - 1})');
    _updateDataCellFormula(sheet, 'k$cidx', '=sum(k5:k${cidx - 1})');
    return cidx;
  }

  void _generateInfoSheet(Worksheet sheet, FALCategory category) {
    final report = ref.read(reportRepositoryProvider).value!;
    sheet.enableSheetCalculations();

    var c = sheet.getRangeByName('g1:h1');
    c.merge();
    c.text = 'Додаток 85';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('a2:i2');
    c.merge();
    c.text = 'ВІДОМІСТЬ';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('a3:i3');
    c.merge();
    c.text =
        'заміру палього                    ${category == FALCategory.diesel ? "ДП" : "АБ"}                   у баках машин';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('a4:i4');
    c.merge();
    c.text = '(найменування пального)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('b5:c5');
    c.merge();
    c.text = report.unitName;
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('b6:c6');
    c.merge();
    c.text = '(підрозділ)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('f5:g5');
    c.merge();
    c.text = 'А4548';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('f6:g6');
    c.merge();
    c.text = '(в/ч)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('A7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Марка машини';

    c = sheet.getRangeByName('b7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Номер машини';

    c = sheet.getRangeByName('c7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Номер останнього дорожнього листа';

    c = sheet.getRangeByName('d7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Одиниця виміру';

    c = sheet.getRangeByName('e7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Обліковується у дорожньому листі';

    c = sheet.getRangeByName('f7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Фактично виявилось';

    c = sheet.getRangeByName('g7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Показання спідометра(одометра)';

    c = sheet.getRangeByName('h7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Залишки';

    c = sheet.getRangeByName('i7');
    c.cellStyle = _reportHeaderStyle;
    c.text = 'Нестача';

    _updateDataCell(sheet, 'a8', '1');
    _updateDataCell(sheet, 'b8', '2');
    _updateDataCell(sheet, 'c8', '3');
    _updateDataCell(sheet, 'd8', '4');
    _updateDataCell(sheet, 'e8', '5');
    _updateDataCell(sheet, 'f8', '6');
    _updateDataCell(sheet, 'g8', '7');
    _updateDataCell(sheet, 'h8', '8');
    _updateDataCell(sheet, 'i8', '9');

    sheet.getRangeByName('a5').columnWidth = 20;
    sheet.getRangeByName('b5').columnWidth = 20;
    sheet.getRangeByName('g5').columnWidth = 18;

    var cidx = _infoAddTableCells(sheet, category);
    cidx += 2;
    c = sheet.getRangeByName('A$cidx:I$cidx');
    c.text =
        '${report.chiefPosition} ${report.unitName} ${report.checkerRank}                          ${report.chiefName}';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.fontSize = 10;
    c.merge();

    ++cidx;
    c = sheet.getRangeByName('c$cidx:g$cidx');
    c.text = '(військове звання, підпис, прізвище, ініціали)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.fontSize = 10;
    c.merge();
  }

  int _infoAddTableCells(Worksheet sheet, FALCategory category) {
    var cidx = 8;
    final cars = ref.watch(carListProvider).value!;
    for (final car in cars) {
      final waybills = ref.read(waybillsByCarProvider(car));
      ++cidx;
      _updateDataCell(sheet, 'A$cidx', car.name);
      _updateDataCell(sheet, 'b$cidx', car.number);
      if (waybills.isEmpty) continue;

      final wb = waybills.last;
      _updateDataCell(sheet, 'c$cidx', wb.number);
      _updateDataCell(sheet, 'd$cidx', 'л');

      final remnant = ref
          .read(fillupsByWaybillProvider(wb))
          .where((fu) => fu.falType.category == category)
          .map(
            (e) => e.beforeLtrs + e.fillupLtrs - e.burnedLtrs,
          )
          .sum
          .round();

      _updateDataCell(sheet, 'e$cidx', remnant.toString(), isNumber: true);
      _updateDataCell(sheet, 'f$cidx', remnant.toString(), isNumber: true);
      _updateDataCell(sheet, 'g$cidx', wb.kmsEnd.round().toString(),
          isNumber: true);
      _updateDataCell(sheet, 'H$cidx', '');
      _updateDataCell(sheet, 'I$cidx', '');
    }

    ++cidx;
    _updateDataCell(sheet, 'A$cidx:D$cidx', 'Усього').merge();
    _updateDataCellFormula(sheet, 'E$cidx', '=SUM(E8:E${cidx - 1})');
    _updateDataCellFormula(sheet, 'F$cidx', '=SUM(F8:F${cidx - 1})');
    _updateDataCell(sheet, 'G$cidx', '');
    _updateDataCell(sheet, 'H$cidx', '');
    _updateDataCell(sheet, 'I$cidx', '');

    ++cidx;
    final report = ref.read(reportRepositoryProvider).value!;
    _updateDataCell(sheet, 'B$cidx:F$cidx',
            'станом на ${DateFormat.yMMMMd("uk").format(report.dtRange.end)}')
        .merge();

    return cidx;
  }

  void _generateTranscriptSheet(Worksheet sheet) {
    sheet.enableSheetCalculations();
    final report = ref.read(reportRepositoryProvider).value!;
    var c = sheet.getRangeByName('A1:J1');
    c.merge();
    c.text = 'РОЗШИФРОВКА';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('A2:J2');
    c.merge();
    c.text = 'напрацювання техніки та витрати пально-мастильних матеріалів';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('b3:c3');
    c.merge();
    c.text = report.unitName;
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('b4:c4');
    c.merge();
    c.text = '(підрозділ)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('i3:j3');
    c.merge();
    c.text = 'за ${DateFormat.yMMMMd("uk").format(report.dtRange.end)}';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('i4:j4');
    c.merge();
    c.text = '(місяць)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('a5');
    c.rowHeight = 50;

    sheet.getRangeByName('b1').columnWidth = 25;
    sheet.getRangeByName('c1').columnWidth = 20;
    sheet.getRangeByName('d1').columnWidth = 20;
    _updateDataCell(sheet, 'a5:a6', '№ п/п').merge();

    c = _updateDataCell(sheet, 'b5:b6', 'Марка машини (стаціонарного двигуна)');
    c.merge();
    _updateDataCell(sheet, 'c5:c6', 'Військовий (заводський номер)').merge();
    _updateDataCell(sheet, 'd5:d6',
            '(пройдено км відпрацьовано мотогодин)  за звітний період')
        .merge();
    _updateDataCell(sheet, 'e5:i5', 'Витрачено (літрів)').merge();
    _updateDataCell(sheet, 'e6', 'ДП');
    _updateDataCell(sheet, 'f6', 'АБ');

    List.generate(
        6,
        (index) => _updateDataCell(sheet, '${String.fromCharCode(index + 65)}7',
            (index + 1).toString()));

    final oilsByIndex = _transcriptAddOilTypes(sheet);
    for (final o in oilsByIndex.entries) {
      final cellCol = String.fromCharCode(o.value + 71);
      final cellIdx = o.value + 7;
      _updateDataCell(sheet, '$cellCol${6}', o.key);
      _updateDataCell(sheet, '$cellCol${7}', '$cellIdx');
    }
    _updateDataCell(sheet, 'j5:j6', 'Примітки').merge();
    _updateDataCell(sheet, 'j7', '10');

    var cidx = _transcriptAddTableCells(sheet, oilIndex: oilsByIndex);
    cidx += 2;
    c = sheet.getRangeByName('A$cidx:J$cidx');
    c.merge();
    c.text =
        'Підставою для заповнення расшифровки являється книга обліку работи машин і витрати ПММ';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    ++cidx;
    c = sheet.getRangeByName('A$cidx:J$cidx');
    c.merge();
    c.text =
        '${report.chiefRank}                                 ${report.chiefName}';
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    ++cidx;
    c = sheet.getRangeByName('C$cidx:F$cidx');
    c.merge();
    c.text = '(військове звання, підпис, прізвище, ініціали)';
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 8;
  }

  int _transcriptAddTableCells(Worksheet sheet,
      {required Map<String, int> oilIndex}) {
    final cars = ref.watch(carListProvider).value!;

    var cidx = 7;
    for (final (idx, car) in cars.indexed) {
      ++cidx;
      _updateDataCell(sheet, 'A$cidx', '${idx + 1}');
      _updateDataCell(sheet, 'B$cidx', car.name);
      _updateDataCell(sheet, 'C$cidx', car.number);
      _updateDataCell(sheet, 'J$cidx', car.note);

      final waybills = ref.read(waybillsByCarProvider(car));
      if (waybills.isEmpty) {
        continue;
      }
      _updateDataCell(
          sheet, 'D$cidx', '${waybills.last.kmsEnd - waybills.first.kmsStart}',
          isNumber: true);

      final Map<String, int> burned = {'df': 0, 'pf': 0};
      for (final wb in waybills) {
        final fillups = ref.read(fillupsByWaybillProvider(wb));
        for (final fu in fillups) {
          if (fu.falType.category == FALCategory.diesel) {
            burned['df'] = burned['df']! + fu.burnedLtrs.round();
          } else if (fu.falType.category == FALCategory.petrol) {
            burned['pf'] = burned['pf']! + fu.burnedLtrs.round();
          } else if (fu.falType.category == FALCategory.oil) {
            if (burned.containsKey(fu.falType.name)) {
              burned[fu.falType.name] =
                  burned[fu.falType.name]! + fu.burnedLtrs.round();
            } else {
              burned[fu.falType.name] = fu.burnedLtrs.round();
            }
          }
        }
      }
      _updateDataCell(sheet, 'E$cidx', burned['df'].toString());
      _updateDataCell(sheet, 'F$cidx', burned['pf'].toString());
      for (final b in burned.entries) {
        if (['df', 'pf'].contains(b.key)) {
          continue;
        }
        final cellCol = String.fromCharCode(oilIndex[b.key]! + 71);
        _updateDataCell(sheet, '$cellCol$cidx', b.value.toString());
      }
    }
    ++cidx;
    _updateDataCell(sheet, 'B$cidx', 'Разом');
    _updateDataCellFormula(sheet, 'D$cidx', '=SUM(D8:D${cidx - 1})');
    _updateDataCellFormula(sheet, 'E$cidx', '=SUM(E8:E${cidx - 1})');
    _updateDataCellFormula(sheet, 'F$cidx', '=SUM(F8:F${cidx - 1})');
    return cidx;
  }

  Map<String, int> _transcriptAddOilTypes(Worksheet sheet) {
    final fillupTypes = ref
        .read(fillupFalTypesProvider)
        .where((e) => e.category == FALCategory.oil);
    return {for (final (i, f) in fillupTypes.indexed) f.name: i};
  }

  void _generateReportingSheet(Worksheet sheet) {
    final report = ref.watch(reportRepositoryProvider).value!;
    var c = sheet.getRangeByName('A1:K1');
    c.merge();
    c.text = 'Додаток 17';
    c.cellStyle.hAlign = HAlignType.right;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 13;

    c = sheet.getRangeByName('A2:K2');
    c.merge();
    c.text = 'ДОНЕСЕННЯ № _______';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 13;

    c = sheet.getRangeByName('A3:K3');
    c.merge();
    c.text = 'про наявність та рух військового майна';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 13;

    c = sheet.getRangeByName('A4:K4');
    c.merge();
    c.text = _formatDateRange(report.dtRange);
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 13;

    c = sheet.getRangeByName('A5:K5');
    c.rowHeight = 4;

    c = sheet.getRangeByName('A6:A7');
    c.merge();
    c.text = 'Реєстраційний номер';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('b6:b7');
    c.merge();
    c.text = 'Номер аркуша';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('c6:e7');
    c.merge();
    c.text = 'Дата документа';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('f6');
    c.text = 'Підстава';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('g6');
    c.text = 'Кому';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('f7');
    c.text = '(мета) операції';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('g7');
    c.text = '(служба забезпечення)';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('h6:k6');
    c.merge();
    c.text = 'Від кого';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('h7:i7');
    c.merge();
    c.text = 'підрозділ (військова частина)';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('j7:k7');
    c.merge();
    c.text = 'Служба забезпечення';
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('a8');
    c.text = '';
    c.cellStyle = _reportCellStyle;
    c = sheet.getRangeByName('b8');
    c.text = '';
    c.cellStyle = _reportCellStyle;
    c = sheet.getRangeByName('c8');
    c.text = '';
    c.cellStyle = _reportCellStyle;
    c = sheet.getRangeByName('d8:e8');
    c.merge();
    c.text = '';
    c.cellStyle = _reportCellStyle;
    c = sheet.getRangeByName('f8');
    c.text = 'Списання';
    c.cellStyle = _reportCellStyle;
    c = sheet.getRangeByName('g8');
    c.text = 'ПММ';
    c.cellStyle = _reportCellStyle;
    c = sheet.getRangeByName('h8:i8');
    c.merge();
    c.text = report.unitName;
    c.cellStyle = _reportCellStyle;

    c = sheet.getRangeByName('a9');
    c.rowHeight = 4;

    c = sheet.getRangeByName('a11');
    c.rowHeight = 100;

    _updateReportHeaderCell(sheet, 'a10:a11', '№ з/п').merge();
    _updateReportHeaderCell(sheet, 'b10:b11', 'Найменування військового майна')
        .merge();
    _updateReportHeaderCell(sheet, 'c10:c11', 'Одиниця виміру').merge();

    _updateReportHeaderCell(sheet, 'd10:d11',
            'перебувало на початок звітнього періоду(${DateFormat("dd.MM.yy").format(report.dtRange.start)})')
        .merge();

    _updateDataCell(sheet, 'e10:g10', 'Надійшло').merge();
    _updateDataCell(sheet, 'h10:j10', 'Вибуло').merge();

    _updateReportHeaderCell(sheet, 'k10:k11',
            'наявність станом на (${DateFormat("dd.MM.yy").format(report.dtRange.end)})')
        .merge();

    _updateReportHeaderCell(sheet, 'e11', 'зі складу військової частини');
    _updateReportHeaderCell(
        sheet, 'f11', 'з інших військових частин (підрозділів)');
    _updateReportHeaderCell(sheet, 'g11', 'усього');
    _updateReportHeaderCell(sheet, 'h11', 'витрати');
    _updateReportHeaderCell(
        sheet, 'i11', 'передано в інші військові частини (підрозділи)');
    _updateReportHeaderCell(sheet, 'j11', 'усього');

    _updateDataCell(sheet, 'a12', '1');
    _updateDataCell(sheet, 'b12', '2').columnWidth = 25;
    _updateDataCell(sheet, 'c12', '3').columnWidth = 12;
    _updateDataCell(sheet, 'd12', '4').columnWidth = 12;
    _updateDataCell(sheet, 'e12', '5').columnWidth = 12;
    _updateDataCell(sheet, 'f12', '6').columnWidth = 12;
    _updateDataCell(sheet, 'g12', '7').columnWidth = 12;
    _updateDataCell(sheet, 'h12', '8').columnWidth = 12;
    _updateDataCell(sheet, 'i12', '9').columnWidth = 12;
    _updateDataCell(sheet, 'j12', '10').columnWidth = 12;
    _updateDataCell(sheet, 'k12', '11').columnWidth = 12;

    final outcomeTypes =
        ref.read(outcomesRepositoryProvider).map((e) => e.falType);
    final fillupTypes = ref.read(fillupFalTypesProvider);

    final falTypes = {
      ...outcomeTypes,
      ...fillupTypes,
    };
    var cidx = 12;
    final falTypesByIndex = {for (final (i, v) in falTypes.indexed) i: v};
    for (final f in falTypesByIndex.entries) {
      final (index, falType) = (f.key, f.value);
      ++cidx;
      _updateDataCell(sheet, 'A$cidx', '${index + 1}');

      // FAL name
      _updateDataCell(sheet, 'b$cidx', falType.name);

      _updateDataCell(sheet, 'c$cidx', 'л/кг');

      // FAL outcome
      final outcome = ref.read(outcomeByFalTypeProvider(falType));
      _updateDataCell(
          sheet,
          'I$cidx',
          outcome != null
              ? '${outcome.amountLtrs.round()}/${outcome.weightKgs.round()}'
              : '0/0');

      final fillups = ref.read(fillupsByFalTypeProvider(falType));

      // FAL income/outcome
      double beforeLtrs = 0;
      double fillupLtrs = 0;
      double fillupOtherMilBaseLtrs = 0;
      double burnedLtrs = 0;
      double outcomeTotal = outcome?.amountLtrs ?? 0;
      for (final fillup in fillups) {
        beforeLtrs += fillup.beforeLtrs;
        burnedLtrs += fillup.burnedLtrs;
        if (fillup.otherMilBase) {
          fillupOtherMilBaseLtrs += fillup.fillupLtrs;
        } else {
          fillupLtrs += fillup.fillupLtrs;
        }
      }
      outcomeTotal += burnedLtrs;
      final fillupTotal = fillupLtrs + fillupOtherMilBaseLtrs;
      final availableTotal = beforeLtrs + fillupTotal - outcomeTotal;
      _updateDataCell(sheet, 'd$cidx',
          '${beforeLtrs.round()}/${(beforeLtrs * falType.density).round()}');
      _updateDataCell(sheet, 'e$cidx',
          '${fillupLtrs.round()}/${(fillupLtrs * falType.density).round()}');
      _updateDataCell(sheet, 'f$cidx',
          '${fillupOtherMilBaseLtrs.round()}/${(fillupOtherMilBaseLtrs * falType.density).round()}');
      _updateDataCell(sheet, 'g$cidx',
          '${fillupTotal.round()}/${(fillupTotal * falType.density).round()}');
      _updateDataCell(sheet, 'h$cidx',
          '${burnedLtrs.round()}/${(burnedLtrs * falType.density).round()}');
      _updateDataCell(sheet, 'j$cidx',
          '${outcomeTotal.round()}/${(outcomeTotal * falType.density).round()}');
      _updateDataCell(sheet, 'k$cidx',
          '${availableTotal.round()}/${(availableTotal * falType.density).round()}');
    }

    ++cidx;
    c = sheet.getRangeByName('A$cidx:K$cidx');
    c.merge();
    c.text = 'Шляхові листи  №:';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 13;

    ++cidx;
    // List of waybills
    final waybills = ref.watch(waybillListProvider).value!;
    final waybillsListString = waybills.map((w) => w.number).join(', ');

    c = sheet.getRangeByName('A$cidx:K$cidx');
    c.merge();
    c.text =
        '$waybillsListString (${NumericToWords().toWords(waybills.length, lowNumberInFemenineGender: true)}) ${waybills.length} ${unitCorrectEnding(waybills.length)}';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 13;
    c.cellStyle.wrapText = true;

    ++cidx;
    c = sheet.getRangeByName('A$cidx:K${cidx + 1}');
    c.merge();
    c.text =
        'Пояснення:Матеріальні засоби служби ПММ витрачено при експлуатації військової техніки вірно, згідно норм витрати до наказів МО №01 від 1999 року та №513 від 2009 року без допущення перевитрат та потребують списання з книг обліку служби ПММ та ФЕС.';
    c.cellStyle.wrapText = true;

    cidx += 2;
    c = sheet.getRangeByName('E$cidx:G$cidx');
    c.merge();
    c.text =
        '${report.chiefRank}                                                    ${report.chiefName}';
    c.cellStyle.fontSize = 12;

    c = sheet.getRangeByName('A$cidx:C$cidx');
    c.merge();
    c.text = '${report.chiefPosition} ${report.unitName}';
    c.cellStyle.fontSize = 12;

    ++cidx;
    c = sheet.getRangeByName('E$cidx:G$cidx');
    c.merge();
    c.text = '(посада, військове звання, підпис, прізвище, ініціали)';
    c.cellStyle.fontSize = 10;
  }

  Range _updateDataCell(Worksheet sheet, String address, String value,
      {isNumber = false}) {
    final cell = sheet.getRangeByName(address);
    cell.cellStyle = _tableStyle;
    if (isNumber) {
      cell.setNumber(double.parse(value));
    } else {
      cell.text = value;
    }
    return cell;
  }

  Range _updateDataCellFormula(Worksheet sheet, String address, String text) {
    final cell = sheet.getRangeByName(address);
    cell.cellStyle = _tableStyle;
    cell.setFormula(text);
    return cell;
  }

  Range _updateReportHeaderCell(Worksheet sheet, String address, String text) {
    final cell = sheet.getRangeByName(address);
    cell.cellStyle = _reportHeaderStyle;
    cell.text = text;
    return cell;
  }

  void _generateRegistrySheet(Worksheet sheet) {
    //Create a Excel document.
    final report = ref.read(reportRepositoryProvider).value!;

    var c = sheet.getRangeByName('A1:F1');
    c.merge();
    c.text =
        'Реєстр № _____ від ${DateFormat.yMMMMd('uk').format(report.dtRange.start)} року';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('A2:F2');
    c.merge();
    c.text = 'прийому-передачі дорожніх листів (д.82)';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('A4:F4');
    c.merge();
    c.text = 'При цьому передаються Дорожні листи (д.82) в кількості';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    c = sheet.getRangeByName('A5:F5');
    c.merge();
    c.text = '__________________________________________, а саме:';
    c.cellStyle.hAlign = HAlignType.center;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    _updateDataCell(sheet, 'A7', '№ з/п').columnWidth = 4;
    _updateDataCell(sheet, 'B7', '№ дорожнього листа').columnWidth = 25;
    _updateDataCell(sheet, 'C7', 'Дата видачі дорожнього листа').columnWidth =
        15;
    _updateDataCell(sheet, 'D7', 'Марка машини').columnWidth = 20;
    _updateDataCell(sheet, 'E7', 'Номерний знак машини').columnWidth = 20;
    _updateDataCell(sheet, 'F7', 'Примітки').columnWidth = 20;

    // Waybills registry
    var cidx = 7;
    final waybills = ref.watch(waybillListProvider).value!;
    for (final (idx, wb) in waybills.indexed) {
      ++cidx;
      // waybill index
      _updateDataCell(sheet, 'A$cidx', '${idx + 1}');

      // waybill number
      _updateDataCell(sheet, 'B$cidx', wb.number);

      // waybill issue date
      _updateDataCell(
          sheet, 'C$cidx', DateFormat('dd.MM.yyyy').format(wb.issueDate!));

      final car = ref.read(carByUuidProvider(wb.carUuid));
      // car brand
      _updateDataCell(sheet, 'D$cidx', car.name);

      // car number
      _updateDataCell(sheet, 'E$cidx', car.number);

      // Remark
      _updateDataCell(sheet, 'F$cidx', car.note);
    }

    cidx += 2;
    c = sheet.getRangeByName('A$cidx:F$cidx');
    c.merge();
    c.text = 'Правильність оформлення дорожніх листів підтверджую:';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    cidx += 2;
    c = sheet.getRangeByName('A$cidx:F$cidx');
    c.merge();
    c.text =
        ' ${report.chiefRank}                                                ${report.chiefName}';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;

    ++cidx;
    c = sheet.getRangeByName('B$cidx:F$cidx');
    c.merge();
    c.text = '(військове звання, підпис, прізвище, ініціали)';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    ++cidx;
    c = sheet.getRangeByName('A$cidx:F$cidx');
    c.merge();
    c.text = 'Правильність оформлення дорожніх листів перевірив:';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    cidx += 2;
    c = sheet.getRangeByName('A$cidx:F$cidx');
    c.merge();
    c.text =
        ' ${report.checkerRank}                                              ${report.checkerName}';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;

    ++cidx;
    c = sheet.getRangeByName('B$cidx:F$cidx');
    c.merge();
    c.text = '(військове звання, підпис, прізвище, ініціали)';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;

    ++cidx;
    c = sheet.getRangeByName('A$cidx:F$cidx');
    c.merge();
    c.text = 'Реєстр прийняв:\nбухгалтер фінансово-економічної служби в/ч ';
    c.cellStyle.hAlign = HAlignType.left;
    c.cellStyle.vAlign = VAlignType.center;
    c.cellStyle.fontSize = 10;
    c.cellStyle.wrapText = true;
    c.rowHeight = 30;

    cidx += 2;
    c = sheet.getRangeByName('A$cidx:F$cidx');
    c.merge();
    c.cellStyle.borders.bottom.lineStyle = LineStyle.thin;
  }
}

String _formatDateRange(DateTimeRange? dtRange) {
  if (dtRange == null) return 'NO DATE SET';
  final startDate = dtRange.start;
  final endDate = dtRange.end;
  DateFormat format = DateFormat('dd.MM.yyyy');
  return 'за період з ${format.format(startDate)} по ${format.format(endDate)} року';
}

@riverpod
ReportService reportService(ReportServiceRef ref) {
  return ReportService(ref: ref);
}
