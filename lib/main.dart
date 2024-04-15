import 'dart:async';
import 'dart:io';

import 'package:donpmm/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  initializeDateFormatting('uk');
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://69d96c053f7ce52a7c9ca400de1f0533@o4505948129984512.ingest.us.sentry.io/4506936782028800';
    },
    // Init your App.
    appRunner: () => runApp(const ProviderScope(
      child: MyApp(),
    )),
  );
}
