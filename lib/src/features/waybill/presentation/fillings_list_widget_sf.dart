import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/fillup.dart';
import 'package:flutter/material.dart';
import 'package:donpmm/src/features/waybill/domain/waybill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FillupDataSource extends DataGridSource {
  late List<Fillup> _fillups;
  List<DataGridRow> dataGridRow = [];
  Color? rowBackgroundColor;
  late FillupList _fillupsRepo;

  FillupDataSource(
      {required List<Fillup> fillups, required FillupList fillupsRepo}) {
    _fillups = fillups;
    _fillupsRepo = fillupsRepo;
    updateDataGridRows();
  }

  void updateDataGridRows() {
    dataGridRow = _fillups.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'uuid', value: e.uuid),
        DataGridCell<String>(columnName: 'falName', value: e.falType.name),
        DataGridCell<num>(columnName: 'density', value: e.falType.density),
        DataGridCell<String>(
            columnName: 'falCategory', value: e.falType.category.name),
        DataGridCell<num>(columnName: 'beforeLtrs', value: e.beforeLtrs),
        DataGridCell<num>(columnName: 'fillupLtrs', value: e.fillupLtrs),
        DataGridCell<num>(columnName: 'burnedLtrs', value: e.burnedLtrs),
        const DataGridCell<Widget>(columnName: 'delete', value: null)
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return e.columnName == 'delete'
          ? Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  final uuid = row.getCells().first.value;
                  dataGridRow = dataGridRow
                      .where(
                          (element) => element.getCells().first.value != uuid)
                      .toList();
                  _fillupsRepo.removeFillupByUuid(uuid);
                  updateDataGridSource();
                },
              ),
            )
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(e.value.toString()),
            );
    }).toList());
  }

  void updateDataGridSource() {
    notifyListeners();
  }
}

class FillingsListWidgetSf extends ConsumerStatefulWidget {
  const FillingsListWidgetSf(
      {super.key, required this.data, required this.waybill});
  final List<Map<String, dynamic>> data;
  final Waybill waybill;

  @override
  FillingsListWidgetSfState createState() => FillingsListWidgetSfState();
}

class FillingsListWidgetSfState extends ConsumerState<FillingsListWidgetSf> {
  FillingsListWidgetSfState();

  final _formKey = GlobalKey<FormState>();
  String? _falName;

  Future<void> _displayTextInputDialog(
      BuildContext context, List<FALType> falTypes) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Нова заправка'),
          content: Form(
              key: _formKey,
              child: Row(
                children: [
                  Flexible(
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        setState(() {
                          _falName = textEditingValue.text;
                        });
                        return falTypes.where((FALType ft) {
                          return ft.name
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        }).map((FALType ft) => '${ft.name}: ${ft.density}');
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'Тип палива',
                            icon: const Icon(Icons.local_gas_station),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Вкажіть тип палива';
                            }
                            return null;
                          },
                          onFieldSubmitted: (String value) {
                            onFieldSubmitted();
                            print('You just typed a new entry  $value');
                          },
                        );
                      },
                      onSelected: (String selection) {
                        _falName = selection;
                        debugPrint('You just selected $selection');
                      },
                    ),
                  ),
                  /* Flexible(
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
                          decoration: const InputDecoration(
                              icon: Icon(Icons.directions_car),
                              labelText: 'Початковий пробіг'))),
                  Flexible(
                      child: TextFormField(
                          validator: validateNotEmpty,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.directions_car),
                              labelText: 'Кінцевий пробіг'))),
                  Flexible(
                      child: TextFormField(
                          validator: validateNotEmpty,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.directions_car),
                              labelText: 'Початковий мотогодинник'))),
                  Flexible(
                      child: TextFormField(
                          validator: validateNotEmpty,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.directions_car),
                              labelText: 'Кінцевий мотогодинник'))),
                  Flexible(
                      child: TextFormField(
                          validator: validateNotEmpty,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.date_range),
                              labelText: 'Дата видачі'))), */
                ],
              )),
          actions: <Widget>[
            TextButton(
              child: Text('Відмінити'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Додати'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fillups = ref.watch(fillupsByWaybillProvider(widget.waybill));
    final fillupsRepo = ref.watch(fillupListProvider.notifier);
    final fillupDataSource =
        FillupDataSource(fillups: fillups, fillupsRepo: fillupsRepo);
    final falTypesState = ref.watch(falTypesRepositoryProvider);
    return switch (falTypesState) {
      AsyncData(:final value) => Column(
          children: [
            SfDataGrid(
              source: fillupDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              footer: MaterialButton(
                onPressed: () {
                  _displayTextInputDialog(context, value);
                },
                child: Text('Додати нову заправку'),
              ),
              columns: <GridColumn>[
                GridColumn(
                    minimumWidth: 90,
                    visible: false,
                    columnName: 'uuid',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'falType',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Тип палива',
                        ))),
                GridColumn(
                    columnName: 'density',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Густина',
                        ))),
                GridColumn(
                    columnName: 'falCategory',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Категорія',
                        ))),
                GridColumn(
                    columnName: 'beforeLtrs',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Перед виїздом',
                        ))),
                GridColumn(
                    columnName: 'fillupLtrs',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Отримано',
                        ))),
                GridColumn(
                    columnName: 'burnedLtrs',
                    label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Витрачено',
                        ))),
                GridColumn(
                    columnName: 'delete',
                    allowSorting: false,
                    allowFiltering: false,
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Видалити'))),
              ],
            ),
          ],
        ),
      _ => CircularProgressIndicator(),
    };
  }
}
