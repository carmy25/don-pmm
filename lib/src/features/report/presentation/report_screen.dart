import 'package:donpmm/src/features/report/application/report_service.dart';
import 'package:donpmm/src/features/report/data/report_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cars/domain/car.dart';
import '../../cars/presentation/car_screen.dart';
import '../../cars/presentation/cars_list_widget.dart';

enum UnitName {
  sadn1vz('1САДн ВЗ'),
  sadn1vu('1САДн ВУ'),
  sadn1sabatr1('1САДн 1САБатр'),
  sadn1sabatr2('1САДн 2САБатр'),
  sadn1sabatr3('1САДн 3САБатр');

  const UnitName(this.name);
  final String name;
}

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends ConsumerState {
  DateTimeRange? _dtRange;
  final TextEditingController unitNameController = TextEditingController();
  final TextEditingController dateinput = TextEditingController();
  String _formatDateToString(DateTime? date) {
    if (date == null) return '-';

    return '${date.day}.${date.month}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final dropdownMenuEntries =
        UnitName.values.map<DropdownMenuEntry<UnitName>>((UnitName item) {
      return DropdownMenuEntry<UnitName>(
        value: item,
        label: item.name,
      );
    }).toList();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Нове Донесення'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: DropdownMenu(
                          dropdownMenuEntries: dropdownMenuEntries,
                          controller: unitNameController,
                          label: const Text('Назва підрозділу'))),
                  Flexible(
                      child: TextField(
                    controller:
                        dateinput, //editing controller of this TextField
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

                      dateinput.text =
                          'З ${_formatDateToString(result?.start)} по ${_formatDateToString(result?.end)}';
                    },
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(top: 14, bottom: 14),
                      child: Text('Машини',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))),
                  IconButton(
                    icon: const Icon(Icons.add_box_rounded),
                    tooltip: 'Додати нову машину',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarScreen(
                                  car: Car(name: '', number: ''),
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
                      _saveReport(context);
                    },
                    child: const Text('Зберегти'),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _showAutoDismissAlert(BuildContext context, String path) {
    showDialog(
      context: context,
      builder: (context) {
        // Schedule a delayed dismissal of the alert dialog after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(); // Close the dialog
        });
        // Return the AlertDialog widget
        return AlertDialog(
          title: const Text('Донесення збережено в'),
          content: Text(path),
        );
      },
    );
  }

  void _saveReport(BuildContext context) async {
    await ref
        .read(reportRepositoryProvider.notifier)
        .createReport(unitName: unitNameController.text, dtRange: _dtRange);
    final repo = ref.read(reportServiceProvider);
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Вкажіть назву файлу:',
      fileName: 'Донесення.xlsx',
    );
    if (outputFile != null) {
      // ignore: use_build_context_synchronously
      _showAutoDismissAlert(context, outputFile);
      repo.saveToFile(outputFile);
    }
  }
}
