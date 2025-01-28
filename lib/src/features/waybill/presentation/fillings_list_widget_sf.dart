import 'package:donpmm/src/common/datagrid_source.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/fillup.dart';
import 'package:donpmm/src/widgets/fillups_datagrid/datagrid_footer.widget.dart';
import 'package:donpmm/src/widgets/fillups_datagrid/fillup_gridcolumn.dart';
import 'package:flutter/material.dart';
import 'package:donpmm/src/features/waybill/domain/waybill.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';

class FillupDataSource extends BaseDataGridSource<Fillup> {
  Color? rowBackgroundColor;
  final FillupList _fillupsRepo;

  FillupDataSource({required FillupList fillupsRepo, required super.data})
      : _fillupsRepo = fillupsRepo;

  @override
  void updateDataGridRows() {
    dataGridRows = data.map<DataGridRow>((e) {
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
  void onDeleteRowPressed(String uuid) {
    _fillupsRepo.removeFillupByUuid(uuid);
  }

  @override
  void onCellSubmitAction(GridColumn column, int dataRowIndex) {
    if (column.columnName == 'beforeLtrs') {
      data[dataRowIndex] = data[dataRowIndex].copyWith(
        beforeLtrs: newCellValue as double,
      );
    } else if (column.columnName == 'fillupLtrs') {
      data[dataRowIndex] = data[dataRowIndex].copyWith(
        fillupLtrs: newCellValue as double,
      );
    } else if (column.columnName == 'burnedLtrs') {
      data[dataRowIndex] = data[dataRowIndex].copyWith(
        burnedLtrs: newCellValue as double,
      );
    }
    _fillupsRepo.addFillup(data[dataRowIndex]);
  }
}

class FillingsListWidgetSf extends ConsumerStatefulWidget {
  const FillingsListWidgetSf({super.key, required this.waybill});
  final Waybill waybill;

  @override
  FillingsListWidgetSfState createState() => FillingsListWidgetSfState();
}

class FillingsListWidgetSfState extends ConsumerState<FillingsListWidgetSf> {
  FillingsListWidgetSfState();

  final _formKey = GlobalKey<FormState>();
  final _densityInput = TextEditingController();
  final _categoryInput = TextEditingController();
  final _beforeLtrsInput = TextEditingController();
  final _fillupLtrsInput = TextEditingController();
  final _burnedLtrsInput = TextEditingController();
  final _falNameFocusNode = FocusNode();

  String? _falName;

  @override
  void dispose() {
    _densityInput.dispose();
    _categoryInput.dispose();
    _falNameFocusNode.dispose();
    super.dispose();
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, List<FALType> falTypes, Function onConfirm) async {
    final width = MediaQuery.of(context).size.width;
    final falCategories = falTypes.map((e) => e.category.name).toSet().toList();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Нова заправка'),
          content: SizedBox(
            width: width - 100,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Autocomplete<String>(
                            optionsBuilder:
                                (TextEditingValue textEditingValue) {
                              if (textEditingValue.text == '') {
                                return const Iterable<String>.empty();
                              }
                              return falTypes.where((FALType ft) {
                                return ft.name.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              }).map(
                                  (FALType ft) => '${ft.name}: ${ft.density}');
                            },
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted) {
                              focusNode.addListener(() {
                                if (!focusNode.hasFocus) {
                                  debugPrint('Focus lost');
                                  setState(() {
                                    _falName = textEditingController.text;
                                  });
                                  onFieldSubmitted();
                                }
                              });
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
                              );
                            },
                            onSelected: (String selection) {
                              setState(() {
                                _falName = selection;
                              });
                              _falName = selection;
                              final [falName, ...density] =
                                  _falName!.split(':');
                              final densityStr =
                                  density.isEmpty ? '' : density[0];
                              _densityInput.text = densityStr;
                              final falType = ref.read(
                                  falTypeByNameAndDensityProvider(falName,
                                      density: double.tryParse(densityStr)));
                              if (falType != null) {
                                _categoryInput.text = falType.category.name;
                              }

                              debugPrint('You just selected $selection');
                            },
                          ),
                        ),
                        Flexible(
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _densityInput,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                validator: validateNotEmptyNumber,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.density_small),
                                    labelText: 'Густина'))),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownMenu<String>(
                              initialSelection: falCategories.first,
                              controller: _categoryInput,
                              onSelected: (String? value) {
                                // This is called when the user selects an item.
                              },
                              dropdownMenuEntries: falCategories
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                  value: value,
                                  label: value,
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: TextFormField(
                                controller: _beforeLtrsInput,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                validator: validateNotEmpty,
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.local_gas_station),
                                    labelText: 'Перед виїздом'))),
                        Flexible(
                            child: TextFormField(
                                controller: _fillupLtrsInput,
                                validator: validateNotEmpty,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.local_gas_station),
                                    labelText: 'Отримано'))),
                        Flexible(
                            child: TextFormField(
                                controller: _burnedLtrsInput,
                                validator: validateNotEmpty,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}'))
                                ],
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.local_gas_station),
                                    labelText: 'Витрачено'))),
                      ],
                    )
                  ],
                )),
          ),
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
                  onConfirm();
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addNewFillupPressed(BuildContext context, List<FALType> falTypes,
      FillupList fillupsRepo, FillupDataSource fillupDataSource) {
    _displayTextInputDialog(context, falTypes, () async {
      var falType = ref.read(falTypeByNameAndDensityProvider(
          _falName!.split(':').first,
          density: double.tryParse(_densityInput.text)));
      if (falType == null) {
        final falTypesRepo = ref.read(falTypesRepositoryProvider.notifier);
        falType = FALType(
            uuid: const Uuid().v4(),
            name: _falName!.split(':').first,
            density: double.tryParse(_densityInput.text)!,
            category: FALCategory.fromName(_categoryInput.text));
        await falTypesRepo.addFalType(falType);
      }
      final fillup = Fillup(
          uuid: const Uuid().v4(),
          falType: falType,
          beforeLtrs: double.tryParse(_beforeLtrsInput.text)!,
          fillupLtrs: double.tryParse(_fillupLtrsInput.text)!,
          burnedLtrs: double.tryParse(_burnedLtrsInput.text)!,
          waybill: widget.waybill.uuid,
          otherMilBase: false);
      fillupsRepo.addFillup(fillup);
      fillupDataSource.data.add(fillup);
      fillupDataSource.updateDataGridRows();
      fillupDataSource.updateDataGridSource();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fillups = ref.watch(fillupsByWaybillProvider(widget.waybill));
    final fillupsRepo = ref.watch(fillupListProvider.notifier);
    final fillupDataSource =
        FillupDataSource(data: fillups, fillupsRepo: fillupsRepo);
    final falTypesState = ref.watch(falTypesRepositoryProvider);
    return switch (falTypesState) {
      AsyncData(:final value) => Column(
          children: [
            SfDataGrid(
              source: fillupDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              allowEditing: true,
              editingGestureType: EditingGestureType.tap,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              footer: DataGridFooterWidget(
                onPressed: () => _addNewFillupPressed(
                    context, value, fillupsRepo, fillupDataSource),
              ),
              columns: <GridColumn>[
                FillupGridColumn(
                  visible: false,
                  columnName: 'uuid',
                  allowEditing: false,
                  labelText: 'ID',
                ),
                FillupGridColumn(
                  columnName: 'falType',
                  allowEditing: false,
                  labelText: 'Тип палива',
                ),
                FillupGridColumn(
                  columnName: 'density',
                  allowEditing: false,
                  labelText: 'Густина',
                ),
                FillupGridColumn(
                    columnName: 'falCategory',
                    allowEditing: false,
                    labelText: 'Категорія'),
                FillupGridColumn(
                  columnName: 'beforeLtrs',
                  labelText: 'Перед виїздом',
                ),
                FillupGridColumn(
                  columnName: 'fillupLtrs',
                  labelText: 'Отримано',
                ),
                FillupGridColumn(
                  columnName: 'burnedLtrs',
                  labelText: 'Витрачено',
                ),
                FillupGridColumn(
                    columnName: 'delete',
                    allowSorting: false,
                    allowFiltering: false,
                    labelText: 'Видалити'),
              ],
            ),
          ],
        ),
      _ => CircularProgressIndicator(),
    };
  }
}
