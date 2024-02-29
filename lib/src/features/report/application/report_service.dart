import 'dart:ffi';
import 'dart:io';

import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/cars/data/cars_repository.dart';
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

    List<int> bytes = workbook.saveSync();
    await File(path).writeAsBytes(bytes);
    workbook.dispose();
  }

  void _generateTranscriptSheet(Worksheet sheet) {
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

    _updateDataCell(sheet, 'a7', '1');
    _updateDataCell(sheet, 'b7', '2');
    _updateDataCell(sheet, 'c7', '3');
    _updateDataCell(sheet, 'd7', '4');
    _updateDataCell(sheet, 'e7', '5');
    _updateDataCell(sheet, 'f7', '6');

    final oilsByIndex = _transcriptAddOilTypes(sheet);
    for (final o in oilsByIndex.entries) {
      final cellCol = String.fromCharCode(o.value + 71);
      final cellIdx = o.value + 7;
      _updateDataCell(sheet, '$cellCol${6}', o.key);
      _updateDataCell(sheet, '$cellCol${7}', '$cellIdx');
    }
    _updateDataCell(sheet, 'j5:j6', 'Примітки').merge();
    _updateDataCell(sheet, 'j7', '10');
  }

  Map<String, int> _transcriptAddOilTypes(Worksheet sheet) {
    final fillupTypes = ref
        .read(fillupFalTypesProvider)
        .where((e) => e.category == FALCategory.oil);
    return {for (final (i, f) in fillupTypes.indexed) f.name: i};
  }

  void _generateReportingSheet(Worksheet sheet) {
    final report = ref.read(reportRepositoryProvider).value!;
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
        '$waybillsListString (${NumericToWords().toWords(waybills.length)}) ${waybills.length} штук';
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
    c.text = '${report.chiefRank} ______________________ ${report.chiefName}';
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

  Range _updateDataCell(Worksheet sheet, String address, String text) {
    final cell = sheet.getRangeByName(address);
    cell.cellStyle = _tableStyle;
    cell.text = text;
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
          sheet, 'C$cidx', DateFormat('dd.MM.yyyy').format(wb.issueDate));

      final car = ref.read(carByUuidProvider(wb.carUuid));
      // car brand
      _updateDataCell(sheet, 'D$cidx', car.name);

      // car number
      _updateDataCell(sheet, 'E$cidx', car.number);

      // Remark
      _updateDataCell(sheet, 'F$cidx', '');
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
