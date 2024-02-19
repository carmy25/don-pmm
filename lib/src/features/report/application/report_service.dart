import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_service.g.dart';

class ReportService {
  ReportService({required this.ref});
  final Ref ref;

  _copyAssetToFile(String assetName, String destPath) async {
    ByteData data = await rootBundle.load(assetName);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(destPath).writeAsBytes(bytes);
  }

  saveToFile(String path) async {
    _copyAssetToFile('assets/template.xlsx', path);
    final excel = await _readExcel(path);
    debugPrint('Excel file: ${excel.hashCode}');
    await _formatReportingTable(excel);
  }

  _formatReportingTable(Excel excel) async {
    for (var row in excel.tables['Донесення']!.rows) {
      for (var cell in row) {
        debugPrint(
            '${cell?.value.toString()} ${cell?.rowIndex}/${cell?.columnIndex}');
      }
    }
  }

  Future<Excel> _readExcel(String path) async {
    final bytes = await File(path).readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    return excel;
  }
}

@riverpod
ReportService reportService(ReportServiceRef ref) {
  return ReportService(ref: ref);
}
