import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/report.dart';

part 'report_repository.g.dart';

@Riverpod(keepAlive: true)
class ReportRepository extends _$ReportRepository {
  @override
  FutureOr<Report?> build() {
    debugPrint('ReportRepos init');
    return null;
  }

  Future<void> createReport(
      {required String unitName,
      required DateTimeRange dtRange,
      required String chiefPosition,
      required String chiefRank,
      required String chiefName,
      required String checkerName,
      required String checkerRank}) async {
    state = AsyncData(Report(
        unitName: unitName,
        dtRange: dtRange,
        chiefPosition: chiefPosition,
        chiefRank: chiefRank,
        chiefName: chiefName,
        checkerName: checkerName,
        checkerRank: checkerRank));
  }
}
