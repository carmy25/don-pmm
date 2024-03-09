import 'package:donpmm/src/features/report/presentation/report_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    const reportForm = ReportForm();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Нове Донесення'),
          actions: const [],
        ),
        body: reportForm);
  }
}
