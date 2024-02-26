import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/fillup.dart';
import 'package:donpmm/src/widgets/subheader_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../data/waybills_repository.dart';
import '../domain/waybill.dart';
import 'fillings_list_widget.dart';

class WaybillScreen extends ConsumerStatefulWidget {
  const WaybillScreen({super.key, required this.waybill});
  final Waybill waybill;

  @override
  // ignore: no_logic_in_create_state
  WaybillScreenState createState() => WaybillScreenState(waybill: waybill);
}

class WaybillScreenState extends ConsumerState {
  final TextEditingController numberInput = TextEditingController();
  final Waybill waybill;
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _fillupsData = [];

  WaybillScreenState({required this.waybill});

  String? _validateNotEmpty(value) {
    if (value == null || value.isEmpty) {
      return "Обов'язкове поле";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    numberInput.text = waybill.number;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шляховий лист'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    controller: numberInput,
                    validator: _validateNotEmpty,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.numbers), //icon of text field
                        labelText: 'Номер листа' //label text of field
                        ),
                  ))
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SubheaderText('Заправки')],
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: FillingsListWidget(
                data: _fillupsData,
                waybill: waybill,
              ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    child: ElevatedButton(
                      onPressed: () => _saveWaybill(context),
                      child: const Text('Зберегти'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveWaybill(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await ref.read(waybillListProvider.notifier).addWaybill(Waybill(
          uuid: waybill.uuid, car: waybill.car, number: numberInput.text));
      for (final o in _fillupsData
          .where((e) => e['comodity'] != null && e['date'] != null)) {
        print('loop ${o["spentLtrs"]}');
        await ref.read(fillupListProvider.notifier).addFillup(Fillup(
            uuid: o['uuid'] ?? const Uuid().v4(),
            falType: FALType.values.firstWhere((e) => e.name == o['comodity']),
            date: DateFormat('yyyy-MM-dd').parse(o['date']),
            beforeLtrs: o['availableLtrs'] ?? 0,
            fillupLtrs: o['gainedLtrs'] ?? 0,
            burnedLtrs: o['spentLtrs'] ?? 0,
            waybill: waybill));
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
