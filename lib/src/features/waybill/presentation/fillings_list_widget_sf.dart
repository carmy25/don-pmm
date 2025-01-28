import 'package:donpmm/src/common/datagrid_source.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/waybill/data/fillups_repository.dart';
import 'package:donpmm/src/features/waybill/domain/fillup.dart';
import 'package:donpmm/src/widgets/fillups_datagrid/datagrid.widget.dart';
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

class FillingsListWidgetSf extends BaseDataGridWidget {
  const FillingsListWidgetSf({super.key, required this.waybill});
  final Waybill waybill;

  @override
  FillingsListWidgetSfState createState() => FillingsListWidgetSfState();
}

class FillingsListWidgetSfState
    extends BaseDataGridState<FillingsListWidgetSf> {
  FillingsListWidgetSfState();

  final _beforeLtrsInput = TextEditingController();
  final _fillupLtrsInput = TextEditingController();
  final _burnedLtrsInput = TextEditingController();

  void _addNewFillupPressed(BuildContext context, List<FALType> falTypes,
      FillupList fillupsRepo, FillupDataSource fillupDataSource) {
    displayTextInputDialog(context, falTypes, () async {
      var falType = ref.read(falTypeByNameAndDensityProvider(
          falName!.split(':').first,
          density: double.tryParse(densityInput.text)));
      falType ??= await createNewFalType(
          falName!,
          double.tryParse(densityInput.text)!,
          FALCategory.fromName(categoryInput.text));
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

  @override
  Widget buildNewFillupDialogInputs() {
    return Row(
      children: [
        Flexible(
            child: TextFormField(
                controller: _beforeLtrsInput,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
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
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
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
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
                decoration: const InputDecoration(
                    icon: Icon(Icons.local_gas_station),
                    labelText: 'Витрачено'))),
      ],
    );
  }
}
