import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/common/rank.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/widgets/input_form_field.dart';
import 'package:donpmm/src/widgets/subheader_text.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:donpmm/src/features/report/application/report_service.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:path_provider/path_provider.dart';

import '../../cars/domain/car.dart';
import '../../cars/presentation/car_screen.dart';
import '../../cars/presentation/cars_list_widget.dart';
import '../../outcome/presentation/outcome_widget.dart';

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
  String? _chiefRank;
  String? _checkerRank;
  final TextEditingController _milBaseInput = TextEditingController();
  final TextEditingController _unitNameInput = TextEditingController();
  final TextEditingController _chiefPositionInput = TextEditingController();
  final TextEditingController _chiefNameInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _checkerNameInput = TextEditingController();
  String _formatDateToString(DateTime? date) {
    if (date == null) return '-';

    return DateFormat('dd.MM.yyyy').format(date);
  }

  Future<bool> _saveReport() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('unitName', _unitNameInput.text);
    prefs.setString('milBase', _milBaseInput.text);
    prefs.setString('chiefPosition', _chiefPositionInput.text);
    String? outputFile = Platform.isAndroid || Platform.isIOS
        ? (await getApplicationDocumentsDirectory()).path
        : (await FilePicker.platform.saveFile(
            dialogTitle: 'Вкажіть назву файлу:',
            fileName: 'Донесення.xlsx',
            allowedExtensions: ['xlsx']));
    if (outputFile != null) {
      final outcomesRepo = ref.read(outcomesRepositoryProvider.notifier);

      for (final o in _outcomeData.where((e) => e['availableLtrs'] != null)) {
        outcomesRepo.addOutcome(
            fal: FAL(
                falType:
                    FALType.values.firstWhere((e) => e.name == o['comodity']),
                uuid: const Uuid().v4(),
                amountLtrs: o['availableLtrs']));
      }
      await ref.read(reportRepositoryProvider.notifier).createReport(
          milBase: _milBaseInput.text,
          unitName: _unitNameInput.text,
          dtRange: _dtRange!,
          chiefPosition: _chiefPositionInput.text,
          chiefRank: _chiefRank ?? '',
          chiefName: _chiefNameInput.text,
          checkerName: _checkerNameInput.text,
          checkerRank: _checkerRank ?? '');
      final reportService = ref.read(reportServiceProvider);
      await reportService.saveToFile(outputFile);
      return true;
    }
    return false;
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _unitNameInput.text = prefs.getString('unitName') ?? '';
    _milBaseInput.text = prefs.getString('milBase') ?? '';
    _chiefPositionInput.text = prefs.getString('chiefPosition') ?? '';
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final rankItems = Rank.values.map<DropdownMenuItem<String>>((Rank item) {
      return DropdownMenuItem<String>(
        value: item.name,
        child: Text(item.name),
      );
    }).toList();
    final report = ref.watch(reportRepositoryProvider).value;
    _checkerNameInput.text = report?.checkerName ?? '';
    _chiefNameInput.text = report?.chiefName ?? '';
    return Form(
      key: _formKey,
      child: Container(
        /* decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),*/
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 1,
                    child: InputFormField(
                      controller: _milBaseInput,
                      text: 'Військова частина', //label text of field
                      icon: const Icon(Icons.home_filled),
                    )),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                    flex: 2,
                    child: InputFormField(
                      controller: _unitNameInput,
                      text: 'Назва підрозділ',
                      icon: const Icon(Icons.group),
                    )),
              ],
            ),
            Row(children: [
              Flexible(
                  child: TextFormField(
                textAlign: TextAlign.center,
                validator: validateNotEmpty,
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
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2028),
                  );
                  setState(() {
                    _dtRange = result;
                  });

                  if (result == null) return;

                  _dateInput.text =
                      'З ${_formatDateToString(result.start)} по ${_formatDateToString(result.end)}';
                },
              )),
            ]),
            const Row(
              children: [
                SubheaderText('Відповідальна особа'),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: InputFormField(
                  controller: _chiefPositionInput,
                  text: 'Посада',
                  icon: const Icon(Icons.supervisor_account),
                )),
                Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: validateNotEmpty,
                        value: _chiefRank,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.security)),
                        onChanged: (String? newValue) {
                          setState(() {
                            _chiefRank = newValue!;
                          });
                        },
                        hint: const Text('Звання'),
                        items: rankItems)),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: InputFormField(
                        controller: _chiefNameInput,
                        icon: const Icon(Icons.person), //icon of text field
                        text: 'Прізвище, ініціали' //label text of field
                        )),
              ],
            ),
            const Row(
              children: [
                SubheaderText('Особа, що перевіряє шляхові листи'),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: validateNotEmpty,
                        value: _checkerRank,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.security)),
                        onChanged: (String? newValue) {
                          setState(() {
                            _checkerRank = newValue!;
                          });
                        },
                        hint: const Text('Звання'),
                        items: rankItems)),
                Flexible(
                    child: TextFormField(
                  validator: validateNotEmpty,
                  controller: _checkerNameInput,
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
                const SubheaderText('Машини/агрегати'),
                IconButton(
                  icon: const Icon(Icons.add_box_rounded),
                  tooltip: 'Додати нову машину/агрегат',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarScreen(
                                car: Car(
                                  uuid: const Uuid().v4(),
                                  name: '',
                                  number: '',
                                  note: '',
                                  consumptionRate: 0,
                                  consumptionRateMH: 0,
                                ),
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
                        const snackBar = SnackBar(
                          content: Text('Збережено!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
