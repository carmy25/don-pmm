import 'dart:io';
import 'package:excel/excel.dart';

import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:donpmm/src/features/report/domain/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_loader.g.dart';

class ReportLoader {
  final Ref ref;
  ReportLoader({required this.ref});

  DateTimeRange _parseDtRangeFromReport(String text) {
    final datesRegExp = RegExp(r'\d[\d\.]+');
    final [start, end] = datesRegExp.allMatches(text).toList();
    final df = DateFormat('dd.mm.yyyy');
    return DateTimeRange(
        start: df.parse(start.group(0)!), end: df.parse(end.group(0)!));
  }

  _loadReportGeneralData(Excel xl) async {
    final reportSheet = xl['Донесення'];
    final unitName =
        reportSheet.cell(CellIndex.indexByString('H8')).value.toString();
    final dtRangeString =
        reportSheet.cell(CellIndex.indexByString('A4')).value.toString();
    final dtRange = _parseDtRangeFromReport(dtRangeString);
    final chiefPosition =
        reportSheet.cell(CellIndex.indexByString('H8')).value.toString();
    debugPrint('UN $unitName, ${dtRange.start}');
    /*await ref.read(reportRepositoryProvider.notifier).createReport(
        unitName: unitName,
        dtRange: dtRange,
        chiefPosition: chiefPosition,
        chiefRank: chiefRank,
        chiefName: chiefName,
        checkerName: checkerName,
        checkerRank: checkerRank,
        milBase: milBase);*/
  }

  loadFromFile(String path) async {
    final bytes = await File(path).readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    await _loadReportGeneralData(excel);
  }
}

@riverpod
ReportLoader reportLoaderService(ReportLoaderServiceRef ref) {
  return ReportLoader(ref: ref);
}
