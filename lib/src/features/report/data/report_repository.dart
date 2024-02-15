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
      {required String unitName, DateTimeRange? dtRange}) async {
    state = AsyncData(Report(unitName: unitName, dtRange: dtRange));
  }
}
