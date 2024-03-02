import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:desktop_window/desktop_window.dart';

import './src/app.dart';

void main() async {
  initializeDateFormatting('uk');
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    // First get the FlutterView.
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

    Size size = view.physicalSize;
    double width = size.width;
    double height = size.height;
    await DesktopWindow.setWindowSize(Size(width * 0.8, height * 0.8));
  }

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
