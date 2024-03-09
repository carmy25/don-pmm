import 'package:donpmm/src/common/fal.dart';
import 'package:donpmm/src/common/rank.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/report/data/outcomes_repository.dart';
import 'package:donpmm/src/widgets/input_form_field.dart';
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
  p1('1САДн ВЗ'),
  p2('1САДн ВУ'),
  p3('1САДн 1САБатр'),
  p4('1САДн 2САБатр'),
  p5('1САДн 3САБатр'),
  p6('2САДн 1САБАтр'),
  p7('2САДн 2САБАтр'),
  p8('2САДн 3САБАтр'),
  p9('2САДн ВМЗ'),
  p10('1БМП ВЗ'),
  p11('1БМП МП'),
  p12('1БМП РВП'),
  p13('1БМП ДШР'),
  p14('1БМП РВ'),
  p15('1БМП МБ'),
  p16('1БМП 2РМП'),
  p17('1БМП 1РМП'),
  p18('1БМП ВзЗв'),
  p19('2БМП ВЗ'),
  p20('2БМП 2РМП'),
  p21('2БМП МП'),
  p22('2БМП МБ'),
  p23('2БМП РВП'),
  p24('2БМП ВзЗв'),
  p25('2БМП ДШР'),
  p26('2БМП РВ'),
  p27('2БМП 1РМП'),
  p28('505 Бат'),
  p29('УБАК'),
  p30('ПВЗ РЗКП'),
  p31('ПВЗ РЗ КТПУ'),
  p32('РДЗ'),
  p33('СОДТ'),
  p34('Рота снайперів'),
  p35('рПТРК'),
  p36('ІСР'),
  p37('БУАР'),
  p38('РР'),
  p39('МР'),
  p40('Коменд. Взвод'),
  p41('БМТЗ РМЗ'),
  p42('БМТЗ РемРота'),
  p43('РХБЗ вз'),
  p44('РЕБ'),
  p45('РеАБатр'),
  p46('Пожежний взвод'),
  p47('ЗРАБатр'),
  p48('БЛ Управління'),
  p49('БЛ РР БТ Техніки'),
  p50('БЛ РР Авт. Техніки'),
  p51('БЛ РР Арт. Озбр.'),
  p52('БЛ Евак. Рота'),
  p53('БЛ АРПБЛ'),
  p54('БЛ АРППММ'),
  p55('БЛ АРПМТЗ'),
  p56('БЛ РМЗ'),
  p57('БЛ Такелажний вз'),
  p58('БЛ ЛВТ'),
  p59('БЛ Рота Охорони'),
  p60('БЛ Медичний пункт'),
  p61('БЛ Взвод звязку'),
  p62('БЛ Інженерний вз'),
  p63('БЛ ВТР'),
  p64('БЛ Пожежна обс.');

  const UnitName(this.name);
  final String name;
}

enum ChiefPosition {
  chief('Kомандир'),
  tvo('ТВО командира'),
  tvovz('ТВО командира взводу');

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
  String? _chiefRank;
  String? _checkerRank;
  final TextEditingController _chiefNameInput = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _checkerNameInput = TextEditingController();
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
          unitName: _unitName ?? '',
          dtRange: _dtRange!,
          chiefPosition: _chiefPosition!,
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
                    child: DropdownButtonFormField<String>(
                        validator: validateNotEmpty,
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
              ],
            ),
            const Row(
              children: [
                SubheaderText('Відповідальна особа'),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: DropdownButtonFormField<String>(
                        validator: validateNotEmpty,
                        value: _chiefPosition,
                        onChanged: (String? newValue) {
                          setState(() {
                            _chiefPosition = newValue!;
                          });
                        },
                        hint: const Text('Посада'),
                        items: chiefItems)),
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
