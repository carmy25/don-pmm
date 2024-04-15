import 'package:donpmm/src/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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
      theme: ThemeData.light(),
      home: const SplashScreen(),
    );
    return app;
  }
}
