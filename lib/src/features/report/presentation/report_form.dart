import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/features/report/data/outcomes_repository.dart';
import 'package:donpmm/src/widgets/subheader_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:donpmm/src/features/report/application/report_service.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:path_provider/path_provider.dart';

import '../../cars/domain/car.dart';
import '../../cars/presentation/car_screen.dart';
import '../../cars/presentation/cars_list_widget.dart';
import 'outcome_widget.dart';

enum UnitName {
  sadn1vz('1САДн ВЗ'),
  sadn1vu('1САДн ВУ'),
  sadn1sabatr1('1САДн 1САБатр'),
  sadn1sabatr2('1САДн 2САБатр'),
  sadn1sabatr3('1САДн 3САБатр');

  const UnitName(this.name);
  final String name;
}

enum ChiefPosition {
  chief('Kомандир'),
  tvo('ТВО командира');

  const ChiefPosition(this.name);
  final String name;
}

class ReportForm extends ConsumerStatefulWidget {
  const ReportForm({super.key});

  @override
  ReportFormState createState() {
    return ReportFormState();
  }
}

class ReportFormState extends ConsumerState<ReportForm> {
  late DateTimeRange? _dtRange;
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _outcomeData = [];
  String? _unitName;
  String? _chiefPosition;
  final TextEditingController _chiefNameInput = TextEditingController();
  final TextEditingController _rankInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  String _formatDateToString(DateTime? date) {
    if (date == null) return '-';

    return DateFormat('dd.MM.yyyy').format(date);
  }

  Future<bool> _saveReport() async {
    String? outputFile = Platform.isAndroid
        ? (await getApplicationDocumentsDirectory()).path
        : (await FilePicker.platform.saveFile(
            dialogTitle: 'Вкажіть назву файлу:',
            fileName: 'Донесення.xlsx',
          ));
    if (outputFile != null) {
      final outcomesRepo = ref.read(outcomesRepositoryProvider.notifier);

      for (final o in _outcomeData.where((e) => e['availableLtrs'] != null)) {
        await outcomesRepo.addOutcome(
            fal: FAL(
                falType:
                    FALType.values.firstWhere((e) => e.name == o['comodity']),
                uuid: const Uuid().v4(),
                amountLtrs: o['availableLtrs']));
      }
      await ref.read(reportRepositoryProvider.notifier).createReport(
          unitName: _unitName ?? '',
          dtRange: _dtRange!,
          chiefPosition: _chiefPosition!,
          chiefRank: _rankInput.text,
          chiefName: _chiefNameInput.text);
      final reportService = ref.read(reportServiceProvider);
      await reportService.saveToFile(outputFile);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final unitItems =
        UnitName.values.map<DropdownMenuItem<String>>((UnitName item) {
      return DropdownMenuItem<String>(
        value: item.name,
        child: Text(item.name),
      );
    }).toList();
    final chiefItems = ChiefPosition.values
        .map<DropdownMenuItem<String>>((ChiefPosition item) {
      return DropdownMenuItem<String>(
        value: item.name,
        child: Text(item.name),
      );
    }).toList();
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: _validateNotEmpty,
                        value: _unitName,
                        onChanged: (String? newValue) {
                          setState(() {
                            _unitName = newValue!;
                          });
                        },
                        hint: const Text('Підрозділ'),
                        items: unitItems)),
                Flexible(
                    child: TextFormField(
                  validator: _validateNotEmpty,
                  controller: _dateInput, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: 'Період' //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    final result = await showDateRangePicker(
                      locale: const Locale("uk", "UA"),
                      context: context,
                      firstDate: DateTime(
                          2024), // tanggal awal yang diperbolehkan di pilih
                      lastDate: DateTime(
                          2025), // tanggal akhir yang diperbolehkan di pilih
                    );
                    setState(() {
                      _dtRange = result;
                    });

                    if (result == null) return;

                    _dateInput.text =
                        'З ${_formatDateToString(result.start)} по ${_formatDateToString(result.end)}';
                  },
                )),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: _validateNotEmpty,
                        value: _chiefPosition,
                        onChanged: (String? newValue) {
                          setState(() {
                            _chiefPosition = newValue!;
                          });
                        },
                        hint: const Text('Посада'),
                        items: chiefItems)),
                Flexible(
                    child: TextFormField(
                  validator: _validateNotEmpty,
                  controller: _rankInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.security), //icon of text field
                      labelText: 'Звання' //label text of field
                      ),
                )),
                Flexible(
                    child: TextFormField(
                  validator: _validateNotEmpty,
                  controller: _chiefNameInput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), //icon of text field
                      labelText: 'Прізвище, ініціали' //label text of field
                      ),
                )),
              ],
            ),
            const Row(
              children: [
                SubheaderText('ПММ передано в інші в/ч'),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: OutcomeWidget(data: _outcomeData))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SubheaderText('Машини'),
                IconButton(
                  icon: const Icon(Icons.add_box_rounded),
                  tooltip: 'Додати нову машину',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarScreen(
                                car: Car(
                                    uuid: const Uuid().v4(),
                                    name: '',
                                    number: ''),
                              )),
                    );
                  },
                ),
              ],
            ),
            const Flexible(child: CarsListWidget()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final saved = await _saveReport();
                      if (saved && context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Зберегти'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String? _validateNotEmpty(value) {
    if (value == null || value.isEmpty) {
      return "Обов'язкове поле";
    }
    return null;
  }
}
