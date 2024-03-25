import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/report.dart';

part 'report_repository.g.dart';

@Riverpod(keepAlive: true)
class ReportRepository extends _$ReportRepository {
  @override
  Report? build() {
    debugPrint('ReportRepos init');
    return null;
  }

  void createReport(
      {required String unitName,
      required DateTimeRange dtRange,
      required String chiefPosition,
      required String chiefRank,
      required String chiefName,
      required String checkerName,
      required String checkerRank,
      required String milBase}) {
    state = Report(
        unitName: unitName,
        milBase: milBase,
        dtRange: dtRange,
        chiefPosition: chiefPosition,
        chiefRank: chiefRank,
        chiefName: chiefName,
        checkerName: checkerName,
        checkerRank: checkerRank);
  }

  void updateReport(Report report) {
    state = report;
  }
}
