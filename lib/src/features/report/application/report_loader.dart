import 'dart:io';
import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/features/cars/data/cars_repository.dart';
import 'package:donpmm/src/features/cars/domain/car.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:excel/excel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

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

  _loadCarsData(Excel xl) async {
    final carsRepo = ref.watch(carListProvider.notifier);
    carsRepo.clear();

    final transcriptSheet = xl['Реєстр шляхових листів'];
    var cidx = 5;
    do {
      final carName =
          transcriptSheet.cell(CellIndex.indexByString('M$cidx')).value;
      if (carName == null || carName.toString().isEmpty) {
        break;
      }
      final carNumber =
          (transcriptSheet.cell(CellIndex.indexByString('N$cidx')).value ?? '')
              .toString();
      final consumptionRate =
          (transcriptSheet.cell(CellIndex.indexByString('G$cidx')).value ?? '')
              .toString();
      final consumptionRateMH =
          (transcriptSheet.cell(CellIndex.indexByString('H$cidx')).value ?? '')
              .toString();
      await carsRepo.addCar(Car(
          uuid: const Uuid().v4(),
          consumptionRate:
              consumptionRate.isEmpty ? 0.0 : double.parse(consumptionRate),
          consumptionRateMH:
              consumptionRateMH.isEmpty ? 0.0 : double.parse(consumptionRateMH),
          name: carName.toString(),
          number: carNumber));
      ++cidx;
    } while (true);
  }

  _loadOutcomeData(Excel xl) async {
    final reportSheet = xl['Донесення'];
    final outcomeRepo = ref.watch(outcomesRepositoryProvider.notifier);
    outcomeRepo.clear();
    var cidx = 13;
    do {
      final comodityName =
          reportSheet.cell(CellIndex.indexByString('B$cidx')).value.toString();
      if (comodityName.startsWith('Шляхові листи')) {
        break;
      }
      final comodityAmountString =
          reportSheet.cell(CellIndex.indexByString('I$cidx')).value.toString();
      debugPrint('_loadOutcomeData: [$comodityName]:[$comodityAmountString]');
      final comodityAmount =
          double.parse(comodityAmountString.split('/').first);
      if (comodityAmount > 0) {
        outcomeRepo.addOutcome(
            fal: FAL(
                uuid: const Uuid().v4(),
                falType:
                    FALType.values.where((e) => e.name == comodityName).first,
                amountLtrs: comodityAmount));
      }
      ++cidx;
    } while (true);
    debugPrint('_loadOutcomeData: done');
  }

  _loadReportGeneralData(Excel xl) async {
    final reportSheet = xl['Донесення'];
    final unitName =
        reportSheet.cell(CellIndex.indexByString('H8')).value.toString();
    final dtRangeString =
        reportSheet.cell(CellIndex.indexByString('A4')).value.toString();
    final dtRange = _parseDtRangeFromReport(dtRangeString);

    final internalSheet = xl['__internal__'];
    final chiefPosition =
        internalSheet.cell(CellIndex.indexByString('a2')).value.toString();
    final chiefRank =
        internalSheet.cell(CellIndex.indexByString('a3')).value.toString();
    final chiefName =
        internalSheet.cell(CellIndex.indexByString('a1')).value.toString();
    final checkerName =
        internalSheet.cell(CellIndex.indexByString('a4')).value.toString();
    final checkerRank =
        internalSheet.cell(CellIndex.indexByString('a5')).value.toString();
    final milBase =
        internalSheet.cell(CellIndex.indexByString('a6')).value.toString();
    await ref.watch(reportRepositoryProvider.notifier).createReport(
        unitName: unitName,
        dtRange: dtRange,
        chiefPosition: chiefPosition,
        chiefRank: chiefRank,
        chiefName: chiefName,
        checkerName: checkerName,
        checkerRank: checkerRank,
        milBase: milBase);
  }

  loadFromFile(String path) async {
    final bytes = await File(path).readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    await _loadReportGeneralData(excel);
    await _loadOutcomeData(excel);
    await _loadCarsData(excel);
  }
}

@riverpod
ReportLoader reportLoaderService(ReportLoaderServiceRef ref) {
  return ReportLoader(ref: ref);
}
