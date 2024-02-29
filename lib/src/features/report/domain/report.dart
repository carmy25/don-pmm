import 'package:flutter/material.dart';

class Report {
  const Report({
    required this.unitName,
    required this.dtRange,
    required this.chiefPosition,
    required this.chiefRank,
    required this.chiefName,
    required this.checkerName,
    required this.checkerRank,
  });
  final String unitName;
  final DateTimeRange dtRange;
  final String chiefPosition;
  final String chiefRank;
  final String chiefName;
  final String checkerRank;
  final String checkerName;
}
