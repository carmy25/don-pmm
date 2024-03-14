import 'package:flutter/material.dart';

class Report {
  Report({
    required this.unitName,
    required this.milBase,
    required this.dtRange,
    required this.chiefPosition,
    required this.chiefRank,
    required this.chiefName,
    required this.checkerName,
    required this.checkerRank,
  });
  final String unitName;
  final String milBase;
  final DateTimeRange dtRange;
  final String chiefPosition;
  final String chiefRank;
  final String chiefName;
  final String checkerRank;
  final String checkerName;
}
