import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/waybill/presentation/fillings_list_widget_sf.dart';
import 'package:donpmm/src/widgets/input_form_field.dart';
import 'package:donpmm/src/widgets/subheader_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../data/waybills_repository.dart';
import '../domain/waybill.dart';

class WaybillScreen extends ConsumerStatefulWidget {
  const WaybillScreen({super.key, required this.waybill});
  final Waybill waybill;

  @override
  WaybillScreenState createState() => WaybillScreenState();
}

class WaybillScreenState extends ConsumerState<WaybillScreen> {
  final TextEditingController _numberInput = TextEditingController();
  final TextEditingController _kmsStartInput = TextEditingController();
  final TextEditingController _kmsEndInput = TextEditingController();
  final TextEditingController _mhStartInput = TextEditingController();
  final TextEditingController _mhEndInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _fillupsData = [];

  WaybillScreenState();

  @override
  Widget build(BuildContext context) {
    final waybill = widget.waybill;
    _numberInput.text = widget.waybill.number;
    _kmsStartInput.text =
        widget.waybill.kmsStart > 0 ? waybill.kmsStart.toString() : '';
    _kmsEndInput.text = waybill.kmsEnd > 0 ? waybill.kmsEnd.toString() : '';
    _mhStartInput.text = waybill.mhStart > 0 ? waybill.mhStart.toString() : '';
    _mhEndInput.text = waybill.mhEnd > 0 ? waybill.mhEnd.toString() : '';
    final wbIssueDate = waybill.issueDate;
    _dateInput.text = wbIssueDate == null ? '' : formatDateText(wbIssueDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шляховий/робочий лист'),
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
                                firstDate: DateTime(2023, 2),
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
                          allowEmpty: true,
                          icon: const Icon(Icons.start), //icon of text field
                          text: 'перед початком (км)')),
                  Flexible(
                      child: InputFormField(
                          isNumeric: true,
                          allowEmpty: true,
                          controller: _kmsEndInput,
                          icon: const Icon(
                              Icons.stop_circle_outlined), //icon of text field
                          text: 'в кінці(км)')),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: InputFormField(
                          isNumeric: true,
                          controller: _mhStartInput,
                          allowEmpty: true,
                          icon: const Icon(Icons.start), //icon of text field
                          text: 'перед початком (мотогодин)')),
                  Flexible(
                      child: InputFormField(
                          isNumeric: true,
                          allowEmpty: true,
                          controller: _mhEndInput,
                          icon: const Icon(
                              Icons.stop_circle_outlined), //icon of text field
                          text: 'в кінці(мотогодин)')),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SubheaderText('Заправки')],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: FillingsListWidgetSf(
                    data: _fillupsData,
                    waybill: waybill,
                  ),
                ),
              ),
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
      final dtString = _dateInput.text;
      final wb = Waybill(
          kmsStart: parseDouble(_kmsStartInput.text),
          kmsEnd: parseDouble(_kmsEndInput.text),
          mhStart: parseDouble(_mhStartInput.text),
          mhEnd: parseDouble(_mhEndInput.text),
          uuid: widget.waybill.uuid,
          carUuid: widget.waybill.carUuid,
          issueDate: DateFormat.yMMMMd('uk').parse(dtString),
          number: _numberInput.text);
      ref.read(waybillListProvider.notifier).addWaybill(wb);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }
}
