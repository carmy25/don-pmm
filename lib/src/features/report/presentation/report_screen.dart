import 'dart:io';

import 'package:donpmm/src/common/rank.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/cars/presentation/cars_list_screen.dart';
import 'package:donpmm/src/features/outcome/presentation/outcome_screen.dart';
import 'package:donpmm/src/features/report/application/report_loader.dart';
import 'package:donpmm/src/features/report/application/report_service.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:donpmm/src/features/report/domain/report.dart';
import 'package:donpmm/src/widgets/input_form_field.dart';
import 'package:donpmm/src/widgets/subheader_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends ConsumerState<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  late DateTimeRange? _dtRange;
  late final FocusNode _chiefRankNode;
  late final FocusNode _checkerRankNode;
  final TextEditingController _chiefRankInput = TextEditingController();
  final TextEditingController _checkerRankInput = TextEditingController();
  final TextEditingController _milBaseInput = TextEditingController();
  final TextEditingController _unitNameInput = TextEditingController();
  final TextEditingController _chiefPositionInput = TextEditingController();
  final TextEditingController _chiefNameInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _checkerNameInput = TextEditingController();

  Future<String?> _getFilepathSave(String basicFilename) async {
    return Platform.isAndroid || Platform.isIOS
        ? '${(await getApplicationDocumentsDirectory()).path}/$basicFilename'
        : (await FilePicker.platform.saveFile(
            dialogTitle: 'Вкажіть назву файлу:',
            fileName: basicFilename,
            allowedExtensions: ['xlsx']));
  }

  Future<String?> _getFilepathOpen() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    return result?.files.single.path!;
  }

  Future<bool> _saveReport() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('unitName', _unitNameInput.text);
    prefs.setString('milBase', _milBaseInput.text);
    prefs.setString('chiefPosition', _chiefPositionInput.text);
    String? outputFile = await _getFilepathSave('Донесення.xlsx');
    if (outputFile != null) {
      await ref.read(reportRepositoryProvider.notifier).createReport(
          milBase: _milBaseInput.text,
          unitName: _unitNameInput.text,
          dtRange: _dtRange!,
          chiefPosition: _chiefPositionInput.text,
          chiefRank: _chiefRankInput.text,
          chiefName: _chiefNameInput.text,
          checkerName: _checkerNameInput.text,
          checkerRank: _checkerRankInput.text);
      final reportService = ref.read(reportServiceProvider);
      await reportService.saveToFile(outputFile);
      return true;
    }
    return false;
  }

  /*void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _unitNameInput.text = prefs.getString('unitName') ?? '';
    _milBaseInput.text = prefs.getString('milBase') ?? '';
    _chiefPositionInput.text = prefs.getString('chiefPosition') ?? '';
  }*/

  @override
  void initState() {
    super.initState();
    _chiefRankNode = FocusNode();
    _checkerRankNode = FocusNode();
    // _loadPreferences();
  }

  @override
  void dispose() {
    super.dispose();
    _chiefRankNode.dispose();
    _checkerRankNode.dispose();
  }

  Future<bool> _openReport() async {
    String? outputFile = await _getFilepathOpen();
    if (outputFile != null) {
      final reportLoader = ref.watch(reportLoaderServiceProvider);
      await reportLoader.loadFromFile(outputFile);
    }
    return true;
  }

  Widget _reportFormWidget(Report? report) {
    if (report != null) {
      _milBaseInput.text = report.milBase;
      _unitNameInput.text = report.unitName;
      _dtRange = report.dtRange;
      _dateInput.text =
          'З ${formatDateToString(report.dtRange.start)} по ${formatDateToString(report.dtRange.end)}';
      _checkerNameInput.text = report.checkerName;
      _checkerRankInput.text = report.checkerRank;
      _chiefPositionInput.text = report.chiefPosition;
      _chiefNameInput.text = report.chiefName;
      _chiefRankInput.text = report.chiefRank;
      debugPrint('Report updated: ${report.milBase}');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Донесення ПММ'),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveReport().then(
                    (saved) {
                      if (saved) {
                        const snackBar = SnackBar(
                          content: Text('Збережено!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  );
                }
              },
              icon: const Icon(Icons.save)),
          IconButton(
              onPressed: () {
                _openReport().then((opened) {
                  if (opened) {
                    const snackBar = SnackBar(
                      content: Text('Відкрито!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              },
              icon: const Icon(Icons.file_open)),
        ],
      ),
      body: Form(
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
                    _dtRange = result;

                    if (result == null) return;

                    _dateInput.text =
                        'З ${formatDateToString(result.start)} по ${formatDateToString(result.end)}';
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
                    child: RawAutocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return ranks.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      textEditingController: _chiefRankInput,
                      focusNode: _chiefRankNode,
                      fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted,
                      ) {
                        return TextFormField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            labelText: 'Звання',
                            icon: Icon(Icons.military_tech),
                          ),
                          focusNode: focusNode,
                          onFieldSubmitted: (String value) {
                            onFieldSubmitted();
                          },
                          validator: validateNotEmpty,
                        );
                      },
                      optionsViewBuilder: (
                        BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options,
                      ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                    child: RawAutocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return ranks.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      textEditingController: _checkerRankInput,
                      focusNode: _checkerRankNode,
                      fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted,
                      ) {
                        return TextFormField(
                          controller: textEditingController,
                          decoration: const InputDecoration(
                            labelText: 'Звання',
                            icon: Icon(Icons.military_tech),
                          ),
                          focusNode: focusNode,
                          onFieldSubmitted: (String value) {
                            onFieldSubmitted();
                          },
                          validator: validateNotEmpty,
                        );
                      },
                      optionsViewBuilder: (
                        BuildContext context,
                        AutocompleteOnSelected<String> onSelected,
                        Iterable<String> options,
                      ) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final String option =
                                      options.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('ПММ передано в інші в/ч',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Icon(Icons.arrow_right)
                        ]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OutcomeScreen()));
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextButton(
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Машини/агрегати',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Icon(Icons.arrow_right)
                        ]),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarsListScreen()));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final report = ref.watch(reportRepositoryProvider);
    return switch (report) {
      AsyncData(:final value) => _reportFormWidget(value),
      AsyncError(:final error) => Text('error: $error'),
      _ => const Text('loading'),
    };
  }
}
