import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'features/report/presentation/startup_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'DON-PMM',
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('uk'),
      ],
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: FutureBuilder<bool>(
          future: () async {
            const msg = 'App started';
            Sentry.captureMessage(msg);
            debugPrint(msg);
            return true;
          }(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) =>
              snapshot.hasData
                  ? const StartupScreen()
                  : const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    )),
    );
    return app;
  }
}
