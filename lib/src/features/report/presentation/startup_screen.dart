import 'package:donpmm/src/features/report/presentation/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartupScreen extends ConsumerWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ReportScreen();
  }
}
