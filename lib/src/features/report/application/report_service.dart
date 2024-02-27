import 'dart:io';

import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/cars/data/cars_repository.dart';
import 'package:donpmm/src/features/report/data/outcomes_repository.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/data/waybills_repository.dart';
import 'package:excel/excel.dart' as excel;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;

part 'report_service.g.dart';

class ReportService {
  ReportService({required this.ref});
  final Ref ref;

  saveToFile(String path) async {
    // final excel = await _readExcel('assets/new_template.xlsx');

    //_formatReportingTable(excel);
    // _fixStyles(excel);
    //_formatRegistryTable(excel);

    final workbook = _generateSFWorkbook();
    List<int> bytes = workbook.saveSync();
    await File(path).writeAsBytes(bytes);
    workbook.dispose();

    //final bytes = excel.save(fileName: path)!;
    //await File(path).writeAsBytes(bytes);
  }

  Workbook _generateSFWorkbook() {
    //Create a Excel document.
    final report = ref.read(reportRepositoryProvider).value!;

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets.addWithName('Реєстр');

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

    final Style tableStyle = workbook.styles.add('style');
    tableStyle.borders.all.lineStyle = LineStyle.thin;
    tableStyle.hAlign = HAlignType.center;
    tableStyle.vAlign = VAlignType.center;
    tableStyle.fontSize = 10;
    tableStyle.wrapText = true;

    c = sheet.getRangeByName('A7');
    c.text = '№ з/п';
    c.columnWidth = 4;
    c.cellStyle = tableStyle;

    c = sheet.getRangeByName('B7');
    c.text = '№ дорожнього листа';
    c.columnWidth = 28;
    c.cellStyle = tableStyle;

    c = sheet.getRangeByName('C7');
    c.text = 'Дата видачі дорожнього листа';
    c.columnWidth = 15;
    c.cellStyle = tableStyle;

    c = sheet.getRangeByName('D7');
    c.text = 'Марка машини';
    c.columnWidth = 20;
    c.cellStyle = tableStyle;

    c = sheet.getRangeByName('E7');
    c.text = 'Номерний знак машини';
    c.columnWidth = 20;
    c.cellStyle = tableStyle;

    c = sheet.getRangeByName('F7');
    c.text = 'Примітки';
    c.columnWidth = 20;
    c.cellStyle = tableStyle;

    // Waybills registry
    var cidx = 8;
    final waybills = ref.watch(waybillListProvider).value!;
    for (final (idx, wb) in waybills.indexed) {
      ++cidx;
      debugPrint('Reg index: ${cidx}, $idx');
      // waybill index
      final numCell = sheet.getRangeByName('A$cidx');
      numCell.cellStyle = tableStyle;
      numCell.text = '${idx + 1}';

      // waybill number
      final numberCell = sheet.getRangeByName('B$cidx');
      numberCell.cellStyle = tableStyle;
      numberCell.text = wb.number;

      // waybill issue date
      final dateCell = sheet.getRangeByName('C$cidx');
      dateCell.cellStyle = tableStyle;
      dateCell.text = DateFormat('dd.MM.yyyy').format(wb.issueDate);

      final car = ref.read(carByUuidProvider(wb.carUuid));
      // car brand
      final carBrandCell = sheet.getRangeByName('D$cidx');
      carBrandCell.cellStyle = tableStyle;
      carBrandCell.text = car.name;

      // car number
      final carNumCell = sheet.getRangeByName('E$cidx');
      carNumCell.cellStyle = tableStyle;
      carNumCell.text = car.number;

      // Remark
      final remarkCell = sheet.getRangeByName('F$cidx');
      remarkCell.cellStyle = tableStyle;
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
        ' ${report.chiefRank}                          ${report.chiefName}';
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
        ' ${report.chiefRank}                          ${report.chiefName}';
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

    return workbook;
  }

  _formatRegistryTable(excel.Excel xl) {
    final report = ref.read(reportRepositoryProvider).value!;
    excel.Sheet sheet = xl['Реєстр'];
    final startDate = report.dtRange.start;

    // Header
    final headerCell = sheet.cell(excel.CellIndex.indexByString('A1'));
    headerCell.value = excel.TextCellValue(
        'Реєстр № _____ від "${DateFormat('dd').format(startDate)}" ${DateFormat('MMMM', 'uk').format(startDate)} ${DateFormat('yyyy').format(startDate)} року');

    // Waybills registry
    var cidx = 8;
    final waybills = ref.watch(waybillListProvider).value!;
    for (final (idx, wb) in waybills.indexed) {
      cidx += idx;
      // waybill index
      final numCell = sheet.cell(excel.CellIndex.indexByString('A$cidx'));
      numCell.cellStyle = excel.CellStyle(
          horizontalAlign: excel.HorizontalAlign.Center,
          fontSize: 10,
          leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          textWrapping: excel.TextWrapping.WrapText);
      numCell.value = excel.TextCellValue('${idx + 1}');

      // waybill number
      final numberCell = sheet.cell(excel.CellIndex.indexByString('B$cidx'));
      numberCell.cellStyle = excel.CellStyle(
          horizontalAlign: excel.HorizontalAlign.Center,
          fontSize: 10,
          leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          textWrapping: excel.TextWrapping.WrapText);
      numberCell.value = excel.TextCellValue(wb.number);

      // waybill issue date
      final dateCell = sheet.cell(excel.CellIndex.indexByString('C$cidx'));
      dateCell.cellStyle = excel.CellStyle(
          horizontalAlign: excel.HorizontalAlign.Center,
          fontSize: 10,
          leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          textWrapping: excel.TextWrapping.WrapText);
      dateCell.value =
          excel.TextCellValue(DateFormat('dd.MM.yyyy').format(wb.issueDate));

      final car = ref.read(carByUuidProvider(wb.carUuid));
      // car brand
      final carBrandCell = sheet.cell(excel.CellIndex.indexByString('D$cidx'));
      carBrandCell.cellStyle = excel.CellStyle(
          horizontalAlign: excel.HorizontalAlign.Center,
          fontSize: 10,
          leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          textWrapping: excel.TextWrapping.WrapText);
      carBrandCell.value = excel.TextCellValue(car.name);

      // car number
      final carNumCell = sheet.cell(excel.CellIndex.indexByString('E$cidx'));
      carNumCell.cellStyle = excel.CellStyle(
          horizontalAlign: excel.HorizontalAlign.Center,
          fontSize: 10,
          leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          textWrapping: excel.TextWrapping.WrapText);
      carNumCell.value = excel.TextCellValue(car.number);

      // Remark
      final remarkCell = sheet.cell(excel.CellIndex.indexByString('F$cidx'));
      remarkCell.cellStyle = excel.CellStyle(
          horizontalAlign: excel.HorizontalAlign.Center,
          fontSize: 10,
          leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
          textWrapping: excel.TextWrapping.WrapText);
      remarkCell.value = const excel.TextCellValue('');
    }

    // Footer
    cidx += 2;
    sheet.merge(excel.CellIndex.indexByString('A$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: const excel.TextCellValue(
            'Правильність оформлення дорожніх листів підтверджую:'));
    final alignLeftStyle = excel.CellStyle(
        horizontalAlign: excel.HorizontalAlign.Left, fontSize: 12);
    sheet.cell(excel.CellIndex.indexByString('A$cidx')).cellStyle =
        alignLeftStyle;

    cidx += 2;
    sheet.merge(excel.CellIndex.indexByString('A$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: excel.TextCellValue(
            '${report.chiefRank}                                                                                                            ${report.chiefName}'));
    final bottomBorderStyle = excel.CellStyle(
        fontSize: 10,
        bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin));
    for (final a in List<String>.generate(
        6, (index) => String.fromCharCode(97 + index),
        growable: false)) {
      sheet.cell(excel.CellIndex.indexByString('$a$cidx')).cellStyle =
          bottomBorderStyle;
    }

    ++cidx;
    sheet.merge(excel.CellIndex.indexByString('B$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: const excel.TextCellValue(
            '(військове звання, підпис, прізвище, ініціали)'));

    ++cidx;
    sheet.merge(excel.CellIndex.indexByString('A$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: const excel.TextCellValue(
            'Правильність оформлення дорожніх листів перевірив:'));

    cidx += 2;
    sheet.merge(excel.CellIndex.indexByString('A$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: const excel.TextCellValue('матрос      Пупкін А.Б.'));
    for (final a in List<String>.generate(
        6, (index) => String.fromCharCode(97 + index),
        growable: false)) {
      sheet.cell(excel.CellIndex.indexByString('$a$cidx')).cellStyle =
          bottomBorderStyle;
    }

    ++cidx;
    sheet.merge(excel.CellIndex.indexByString('B$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: const excel.TextCellValue(
            '(військове звання, підпис, прізвище, ініціали)'));
    ++cidx;
    sheet.merge(excel.CellIndex.indexByString('A$cidx'),
        excel.CellIndex.indexByString('F$cidx'),
        customValue: const excel.TextCellValue(
            'Реєстр прийняв:\nбухгалтер фінансово-економічної служби в/ч '));

    cidx += 2;
    for (final a in List<String>.generate(
        6, (index) => String.fromCharCode(97 + index),
        growable: false)) {
      sheet.cell(excel.CellIndex.indexByString('$a$cidx')).cellStyle =
          bottomBorderStyle;
    }
  }

  _formatReportingTable(excel.Excel xl) {
    final report = ref.read(reportRepositoryProvider).value!;
    excel.Sheet reportSheet = xl['Донесення'];

    // Unit name
    var cell = reportSheet.cell(excel.CellIndex.indexByString('H8'));
    cell.value = excel.TextCellValue(report.unitName);

    // Date range
    cell = reportSheet.cell(excel.CellIndex.indexByString('A4'));
    cell.value = excel.TextCellValue(_formatDateRange(report.dtRange));

    DateFormat format = DateFormat('dd.MM.yy');
    // Start date
    cell = reportSheet.cell(excel.CellIndex.indexByString('D10'));
    final startText =
        'перебувало на початок звітнього періоду(${format.format(report.dtRange.start)})';
    cell.value = excel.TextCellValue(startText);

    // End date
    cell = reportSheet.cell(excel.CellIndex.indexByString('K10'));
    final endText =
        'наявність станом на (${format.format(report.dtRange.end)})';
    cell.value = excel.TextCellValue(endText);

    final outcomeTypes =
        ref.read(outcomesRepositoryProvider).map((e) => e.falType);
    final fillupTypes = ref.read(fillupFalTypesProvider);

    final falTypes = {
      ...outcomeTypes,
      ...fillupTypes,
    };

    // build types index
    final falTypesByIndex = {for (final (i, v) in falTypes.indexed) i: v};
    for (final f in falTypesByIndex.entries) {
      final (index, falType) = (f.key, f.value);
      final cidx = index + 13;

      // FAL name
      final nameCell =
          reportSheet.cell(excel.CellIndex.indexByString('B$cidx'));
      nameCell.value = excel.TextCellValue(falType.name);

      // FAL outcome
      final amountCell =
          reportSheet.cell(excel.CellIndex.indexByString('I$cidx'));
      final outcome = ref.read(outcomeByFalTypeProvider(falType));
      amountCell.value = outcome != null
          ? excel.TextCellValue(
              '${outcome.amountLtrs.round()}/${outcome.weightKgs.round()}')
          : const excel.TextCellValue('0/0');

      final fillups = ref.read(fillupsByFalTypeProvider(falType));

      // FAL income/outcome
      final unitsCell =
          reportSheet.cell(excel.CellIndex.indexByString('C$cidx'));
      final beforeCell =
          reportSheet.cell(excel.CellIndex.indexByString('D$cidx'));
      final incomeCell =
          reportSheet.cell(excel.CellIndex.indexByString('E$cidx'));
      final incomeOtherMilBaseCell =
          reportSheet.cell(excel.CellIndex.indexByString('F$cidx'));
      final incomeTotalCell =
          reportSheet.cell(excel.CellIndex.indexByString('G$cidx'));
      final burnedCell =
          reportSheet.cell(excel.CellIndex.indexByString('H$cidx'));
      final outcomeTotalCell =
          reportSheet.cell(excel.CellIndex.indexByString('J$cidx'));
      final availableCell =
          reportSheet.cell(excel.CellIndex.indexByString('K$cidx'));
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
      unitsCell.value = const excel.TextCellValue('л/кг');
      beforeCell.value = excel.TextCellValue(
          '${beforeLtrs.round()}/${(beforeLtrs * falType.density).round()}');
      incomeCell.value = excel.TextCellValue(
          '${fillupLtrs.round()}/${(fillupLtrs * falType.density).round()}');
      incomeOtherMilBaseCell.value = excel.TextCellValue(
          '${fillupOtherMilBaseLtrs.round()}/${(fillupOtherMilBaseLtrs * falType.density).round()}');
      incomeTotalCell.value = excel.TextCellValue(
          '${fillupTotal.round()}/${(fillupTotal * falType.density).round()}');
      outcomeTotalCell.value = excel.TextCellValue(
          '${outcomeTotal.round()}/${(outcomeTotal * falType.density).round()}');
      burnedCell.value = excel.TextCellValue(
          '${burnedLtrs.round()}/${(burnedLtrs * falType.density).round()}');
      availableCell.value = excel.TextCellValue(
          '${availableTotal.round()}/${(availableTotal * falType.density).round()}');
    }

    // Reporting footer
    final footerText =
        '${report.chiefPosition} ${report.unitName} ${report.chiefRank}     _____________________________${report.chiefName}______';
    final footerCell = reportSheet.cell(excel.CellIndex.indexByString('A28'));
    footerCell.value = excel.TextCellValue(footerText);

    // List of waybills
    final waybills = ref.watch(waybillListProvider).value!;
    final waybillsListString = waybills.map((w) => w.number).join(', ');
    final waybillsCell = reportSheet.cell(excel.CellIndex.indexByString('A24'));
    waybillsCell.value = excel.TextCellValue(
        '$waybillsListString (${NumericToWords().toWords(waybills.length)}) ${waybills.length} штук');
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
