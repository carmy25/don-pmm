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
    return switch (waybills) {
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (_, i) {
            final wb = value[i];
            return ListTile(
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
        ),
      AsyncError(:final error) => Text('error: $error'),
      _ => const Text('loading'),
    };
  }
}
