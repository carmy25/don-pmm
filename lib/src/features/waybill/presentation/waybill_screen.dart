import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/fillup.dart';
import 'package:donpmm/src/widgets/input_form_field.dart';
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
  final TextEditingController _numberInput = TextEditingController();
  final TextEditingController _kmsStartInput = TextEditingController();
  final TextEditingController _kmsEndInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final Waybill waybill;
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _fillupsData = [];

  WaybillScreenState({required this.waybill});

  @override
  Widget build(BuildContext context) {
    _numberInput.text = waybill.number;
    _kmsStartInput.text =
        waybill.kmsStart > 0 ? waybill.kmsStart.toString() : '';
    _kmsEndInput.text = waybill.kmsEnd > 0 ? waybill.kmsEnd.toString() : '';
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
                    controller: _numberInput,
                    validator: validateNotEmpty,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.numbers), //icon of text field
                        labelText: 'Номер листа' //label text of field
                        ),
                  )),
                  Flexible(
                      child: TextFormField(
                          validator: validateNotEmpty,
                          controller: _dateInput,
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: 'Дата видачі' //label text of field
                              ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2024, 2),
                                lastDate: DateTime(2100));
                            if (date == null) {
                              return;
                            }
                            _dateInput.text =
                                DateFormat.yMMMMd('uk').format(date);
                          }))
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SubheaderText('Показання спідометра(одометра)')],
              ),
              Row(
                children: [
                  Flexible(
                      child: InputFormField(
                          isNumeric: true,
                          controller: _kmsStartInput,
                          icon: const Icon(Icons.start), //icon of text field
                          text: 'перед початком(км або год)')),
                  Flexible(
                      child: InputFormField(
                          isNumeric: true,
                          controller: _kmsEndInput,
                          icon: const Icon(
                              Icons.stop_circle_outlined), //icon of text field
                          text: 'в кінці(км або год)')),
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
      ref.read(waybillListProvider.notifier).addWaybill(Waybill(
          kmsStart: double.parse(_kmsStartInput.text),
          kmsEnd: double.parse(_kmsEndInput.text),
          uuid: waybill.uuid,
          carUuid: waybill.carUuid,
          issueDate: DateFormat.yMMMMd('uk').parse(_dateInput.text),
          number: _numberInput.text));
      for (final o in _fillupsData
          .where((e) => e['comodity'] != null && e['date'] != null)) {
        await ref.read(fillupListProvider.notifier).addFillup(Fillup(
            uuid: o['uuid'] ?? const Uuid().v4(),
            falType: FALType.values.firstWhere((e) => e.name == o['comodity']),
            date: DateFormat('yyyy-MM-dd').parse(o['date']),
            beforeLtrs: o['availableLtrs'] ?? 0,
            fillupLtrs: o['gainedLtrs'] ?? 0,
            burnedLtrs: o['spentLtrs'] ?? 0,
            otherMilBase: o['otherMilBase'] ?? false,
            waybill: waybill));
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
