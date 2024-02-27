import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './src/app.dart';

void main() {
  initializeDateFormatting('uk');
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
