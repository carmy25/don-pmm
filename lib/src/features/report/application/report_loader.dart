import 'dart:io';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal.dart';
import 'package:donpmm/src/features/cars/data/cars_repository.dart';
import 'package:donpmm/src/features/cars/domain/car.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/data/waybills_repository.dart';
import 'package:donpmm/src/features/waybill/domain/fillup.dart';
import 'package:donpmm/src/features/waybill/domain/waybill.dart';
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
    final df = DateFormat('dd.MM.yyyy');
    return DateTimeRange(
        start: df.parse(start.group(0)!), end: df.parse(end.group(0)!));
  }

  _loadCarsData(Excel xl) {
    final carsRepo = ref.watch(carListProvider.notifier);
    carsRepo.clear();

    final sheet = xl['__internal__'];
    var cidx = 1;
    do {
      final carName = sheet.cell(CellIndex.indexByString('c$cidx')).value;
      if (carName == null || carName.toString().isEmpty) {
        break;
      }
      final carUnderRepair =
          sheet.cell(CellIndex.indexByString('B$cidx')).value;
      final carNumber = sheet.cell(CellIndex.indexByString('D$cidx')).value;
      final carNote = sheet.cell(CellIndex.indexByString('e$cidx')).value;
      final consumptionRate =
          sheet.cell(CellIndex.indexByString('f$cidx')).value;
      final consumptionRateMH =
          sheet.cell(CellIndex.indexByString('g$cidx')).value;
      final carUuid = sheet.cell(CellIndex.indexByString('h$cidx')).value;
      carsRepo.addCar(Car(
          uuid: carUuid.toString(),
          note: carNote == null ? '' : carNote.toString(),
          underRepair: carUnderRepair?.toString().parseBool() ?? false,
          consumptionRate: double.parse(consumptionRate!.toString()),
          consumptionRateMH: double.parse(consumptionRateMH!.toString()),
          name: carName.toString(),
          number: carNumber.toString()));
      ++cidx;
    } while (true);
  }

  _loadOutcomeData(Excel xl) async {
    final reportSheet = xl['Донесення'];
    final outcomeRepo = ref.watch(outcomesRepositoryProvider.notifier);
    final falTypes = await ref.watch(falTypesRepositoryProvider.future);
    outcomeRepo.clear();
    var cidx = 13;
    do {
      final comodityName =
          reportSheet.cell(CellIndex.indexByString('B$cidx')).value.toString();
      if (comodityName.startsWith('Шляхові листи') || comodityName == 'null') {
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
                falType: falTypes.where((e) => e.name == comodityName).first,
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
    ref.watch(reportRepositoryProvider.notifier).createReport(
        unitName: unitName,
        dtRange: dtRange,
        chiefPosition: chiefPosition,
        chiefRank: chiefRank,
        chiefName: chiefName,
        checkerName: checkerName,
        checkerRank: checkerRank,
        milBase: milBase);
  }

  dynamic _getCellValue(Sheet sheet, String address) {
    final value = switch (sheet.cell(CellIndex.indexByString(address)).value) {
      (IntCellValue v) => v.value.toDouble(),
      (DoubleCellValue v) => v.value,
      (TextCellValue v) => v.value.text,
      (BoolCellValue v) => v.value,
      (DateCellValue v) => v.asDateTimeLocal(),
      _ => 0
    };
    return value;
  }

  _loadFillupsData(Excel xl) async {
    final falTypes = ref.read(falTypesRepositoryProvider).value!;
    final fuRepo = ref.read(fillupListProvider.notifier);
    fuRepo.clear();

    final sheet = xl['__internal__'];
    var cidx = 1;
    do {
      final fuUuid = sheet.cell(CellIndex.indexByString('q$cidx')).value;
      if (fuUuid == null || fuUuid.toString().isEmpty) {
        break;
      }
      final wb =
          ref.read(waybillByUuidProvider(_getCellValue(sheet, 'w$cidx')));
      fuRepo.addFillup(Fillup(
        uuid: fuUuid.toString(),
        falType: falTypes
            .where((f) => f.uuid == _getCellValue(sheet, 'r$cidx'))
            .first,
        beforeLtrs: _getCellValue(sheet, 't$cidx'),
        fillupLtrs: _getCellValue(sheet, 'u$cidx'),
        burnedLtrs: _getCellValue(sheet, 'v$cidx'),
        waybill: wb!.uuid,
        otherMilBase: _getCellValue(sheet, 'x$cidx') == 'true' ? true : false,
      ));
      ++cidx;
    } while (true);
  }

  void _loadWaybillsData(Excel xl) {
    final wbRepo = ref.read(waybillListProvider.notifier);

    wbRepo.clear();

    final sheet = xl['__internal__'];
    var cidx = 1;
    do {
      final wbUuid = sheet.cell(CellIndex.indexByString('I$cidx')).value;
      if (wbUuid == null || wbUuid.toString().isEmpty) {
        break;
      }
      final wbIssueDate =
          sheet.cell(CellIndex.indexByString('J$cidx')).value as DateCellValue;
      final wbNumber = _getCellValue(sheet, 'K$cidx');
      final wbKmsStart = _getCellValue(sheet, 'L$cidx');
      final wbKmsEnd = _getCellValue(sheet, 'M$cidx');
      final wbMhStart = _getCellValue(sheet, 'N$cidx');
      final wbMhEnd = _getCellValue(sheet, 'O$cidx');
      final wbCarUuid = _getCellValue(sheet, 'P$cidx');
      wbRepo.addWaybill(Waybill(
        uuid: wbUuid.toString(),
        issueDate: wbIssueDate.asDateTimeLocal(),
        number: wbNumber,
        kmsStart: wbKmsStart,
        kmsEnd: wbKmsEnd,
        mhStart: wbMhStart,
        mhEnd: wbMhEnd,
        carUuid: wbCarUuid,
      ));
      ++cidx;
    } while (true);
  }

  Future<void> _loadFALTypesData(Excel xl) async {
    await ref.read(falTypesRepositoryProvider.future);
    final falTypesRepo = ref.read(falTypesRepositoryProvider.notifier);
    falTypesRepo.clear();
    final sheet = xl['__internal__'];
    var cidx = 1;
    do {
      final ftUuid = sheet.cell(CellIndex.indexByString('y$cidx')).value;
      if (ftUuid == null || ftUuid.toString().isEmpty) {
        break;
      }
      final ftName = _getCellValue(sheet, 'z$cidx');
      final category = FALCategory.fromName(_getCellValue(sheet, 'aa$cidx'));
      final density = _getCellValue(sheet, 'ab$cidx');
      await falTypesRepo.addFalType(FALType(
        uuid: ftUuid.toString(),
        name: ftName,
        category: category,
        density: density,
      ));
      ++cidx;
    } while (true);
  }

  loadFromFile(String path) async {
    final bytes = await File(path).readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    await _loadFALTypesData(excel);
    await _loadReportGeneralData(excel);
    await _loadOutcomeData(excel);
    _loadCarsData(excel);
    _loadWaybillsData(excel);
    await _loadFillupsData(excel);
  }
}

@riverpod
ReportLoader reportLoaderService(Ref ref) {
  return ReportLoader(ref: ref);
}
