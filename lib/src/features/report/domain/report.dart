import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
// part 'report.g.dart';

@freezed
class Report with _$Report {
  factory Report({
    required String unitName,
    required String milBase,
    required DateTimeRange dtRange,
    required String chiefPosition,
    required String chiefRank,
    required String chiefName,
    required String checkerName,
    required String checkerRank,
  }) = _Report;
}
