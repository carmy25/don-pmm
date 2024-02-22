import 'dart:io';

import 'package:donpmm/src/features/report/data/outcomes_repository.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:excel/excel.dart' as excel;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_service.g.dart';

class ReportService {
  ReportService({required this.ref});
  final Ref ref;

  saveToFile(String path) async {
    final excel = await _readExcel('assets/new_template.xlsx');

    _formatReportingTable(excel);
    _fixStyles(excel);

    final bytes = excel.save(fileName: path)!;
    await File(path).writeAsBytes(bytes);
  }

  _fixStyles(excel.Excel excel) {
    _fixReportStyles(excel);
  }

  _fixReportStyles(excel.Excel xl) {
    excel.Sheet reportSheet = xl['Донесення'];
    final alignCenterStyle =
        excel.CellStyle(horizontalAlign: excel.HorizontalAlign.Center);
    var cell = reportSheet.cell(excel.CellIndex.indexByString('A2'));
    cell.cellStyle = alignCenterStyle;

    cell = reportSheet.cell(excel.CellIndex.indexByString('A3'));
    cell.cellStyle = alignCenterStyle;

    cell = reportSheet.cell(excel.CellIndex.indexByString('A4'));
    cell.cellStyle = alignCenterStyle;

    final codesStyle = excel.CellStyle(
        horizontalAlign: excel.HorizontalAlign.Center,
        leftBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
        rightBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
        bottomBorder: excel.Border(borderStyle: excel.BorderStyle.Thin),
        fontSize: 10,
        fontFamily: 'Times New Roman');

    for (final a in List<String>.generate(
        11, (index) => String.fromCharCode(97 + index),
        growable: false)) {
      reportSheet.cell(excel.CellIndex.indexByString('${a}12')).cellStyle =
          codesStyle;
    }
  }

  _formatReportingTable(excel.Excel xl) {
    final report = ref.read(reportRepositoryProvider);
    excel.Sheet reportSheet = xl['Донесення'];

    // Unit name
    var cell = reportSheet.cell(excel.CellIndex.indexByString('H8'));
    cell.value = excel.TextCellValue(report.value?.unitName ?? 'No Name');

    // Date range
    cell = reportSheet.cell(excel.CellIndex.indexByString('A4'));
    cell.value = excel.TextCellValue(_formatDateRange(report.value?.dtRange));

    if (report.value?.dtRange == null) return;
    DateFormat format = DateFormat('dd.MM.yy');
    // Start date
    cell = reportSheet.cell(excel.CellIndex.indexByString('D10'));
    final startText =
        'перебувало на початок звітнього періоду(${format.format(report.value!.dtRange.start)})';
    cell.value = excel.TextCellValue(startText);

    // End date
    cell = reportSheet.cell(excel.CellIndex.indexByString('K10'));
    final endText =
        'наявність станом на (${format.format(report.value!.dtRange.end)})';
    cell.value = excel.TextCellValue(endText);

    _formatReportingTableOutcome(reportSheet);
  }

  _formatReportingTableOutcome(excel.Sheet sheet) {
    final outcomes = ref.read(outcomesRepositoryProvider).value;
    for (final (index, outcome) in outcomes!.indexed) {
      final cidx = index + 13;
      final nameCell = sheet.cell(excel.CellIndex.indexByString('B$cidx'));
      nameCell.value = excel.TextCellValue(outcome.falType.name);

      final amountCell = sheet.cell(excel.CellIndex.indexByString('I$cidx'));
      amountCell.value = excel.TextCellValue(
          '${outcome.amountLtrs.round()}/${outcome.weightKgs.round()}');
    }
  }

  Future<excel.Excel> _readExcel(String name) async {
    ByteData data = await rootBundle.load(name);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return excel.Excel.decodeBytes(bytes);
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
