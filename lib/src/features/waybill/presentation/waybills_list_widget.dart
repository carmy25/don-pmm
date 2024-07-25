import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cars/domain/car.dart';
import '../data/waybills_repository.dart';
import 'waybill_screen.dart';

class WaybillsListWidget extends ConsumerWidget {
  const WaybillsListWidget({super.key, required this.car});
  final Car car;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waybills = ref.watch(waybillsByCarProvider(car));
    final report = ref.watch(reportRepositoryProvider);
    return ListView.builder(
      itemCount: waybills.length,
      itemBuilder: (_, i) {
        final wb = waybills[i];
        final reportStart = report!.dtRange.start;
        return ListTile(
          leading: Icon(wb.issueDate!
                  .isAfter(reportStart.subtract(const Duration(days: 1)))
              ? Icons.online_prediction
              : Icons.warning),
          title: Text(wb.number),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WaybillScreen(waybill: wb)),
            );
          }, // Handle your onTap here.
        );
      },
    );
  }
}
