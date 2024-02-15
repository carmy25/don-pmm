import 'package:donpmm/src/features/report/presentation/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewLoadReportScreen extends ConsumerWidget {
  const NewLoadReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дон-ПММ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReportScreen()),
                );
              },
              child: const Text('Нове Донесення'),
            ),
            const SizedBox(
              height: 8,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {},
              child: const Text('Відкрити Донесення'),
            ),
          ],
        ),
      ),
    );
  }
}
