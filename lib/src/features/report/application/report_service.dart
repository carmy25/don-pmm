import 'dart:io';

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
  }
}

@riverpod
ReportService reportService(ReportServiceRef ref) {
  return ReportService(ref: ref);
}
