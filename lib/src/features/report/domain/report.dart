import 'package:flutter/material.dart';

class Report {
  const Report({
    required this.unitName,
    required this.dtRange,
    required this.chiefPosition,
    required this.chiefRank,
    required this.chiefName,
  });
  final String unitName;
  final DateTimeRange dtRange;
  final String chiefPosition;
  final String chiefRank;
  final String chiefName;
}
