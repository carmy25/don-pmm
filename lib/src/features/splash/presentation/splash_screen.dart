import 'package:donpmm/src/features/report/presentation/report_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset('assets/splash.png'),
        title: const Text(
          '        Донесення ПММ\n37 Бригада Морської піхоти',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 21, 97, 159),
        showLoader: true,
        loadingText: const Text("Завантаження..."),
        futureNavigator: () async {
          const msg = 'App started';
          Sentry.captureMessage(msg);
          debugPrint(msg);
          await Future.delayed(const Duration(seconds: 2));
          return const ReportScreen();
        }());
  }
}
