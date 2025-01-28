import 'package:donpmm/src/common/datagrid_source.dart';
import 'package:donpmm/src/common/utils.dart';
import 'package:donpmm/src/features/fal/data/fal_types_repository.dart';
import 'package:donpmm/src/features/fal/domain/fal.dart';
import 'package:donpmm/src/features/fal/domain/fal_type.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:donpmm/src/widgets/fillups_datagrid/datagrid.widget.dart';
import 'package:donpmm/src/widgets/fillups_datagrid/datagrid_footer.widget.dart';
import 'package:donpmm/src/widgets/fillups_datagrid/fillup_gridcolumn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:uuid/uuid.dart';

class OutcomeDataSource extends BaseDataGridSource<FAL> {
  late final OutcomesRepository _outcomesRepo;

  OutcomeDataSource(
      {required OutcomesRepository outcomesRepo, required super.data})
      : _outcomesRepo = outcomesRepo;

  @override
  void onDeleteRowPressed(String uuid) {
    _outcomesRepo.removeOutcomeByUuid(uuid);
  }

  @override
  void onCellSubmitAction(GridColumn column, int dataRowIndex) {
    if (column.columnName == 'amountLtrs') {
      data[dataRowIndex] = data[dataRowIndex].copyWith(
        amountLtrs: newCellValue as double,
      );
    }
    _outcomesRepo.addOutcome(fal: data[dataRowIndex]);
  }

  @override
  void updateDataGridRows() {
    dataGridRows = data.map<DataGridRow>((FAL e) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'uuid', value: e.uuid),
        DataGridCell<String>(columnName: 'falName', value: e.falType.name),
        DataGridCell<num>(columnName: 'density', value: e.falType.density),
        DataGridCell<String>(
            columnName: 'falCategory', value: e.falType.category.name),
        DataGridCell<num>(columnName: 'amountLtrs', value: e.amountLtrs),
        const DataGridCell<Widget>(columnName: 'delete', value: null)
      ]);
    }).toList();
  }
}

class OutcomeWidgetSf extends BaseDataGridWidget {
  const OutcomeWidgetSf({super.key});

  @override
  OutcomeWidgetSfState createState() => OutcomeWidgetSfState();
}

class OutcomeWidgetSfState extends BaseDataGridState<OutcomeWidgetSf> {
  final _amountLtrsInput = TextEditingController();
  void _addNewOutcomePressed(BuildContext context, List<FALType> falTypes,
      OutcomesRepository outcomesRepo, OutcomeDataSource outcomeDataSource) {
    displayTextInputDialog(context, falTypes, () async {
      var falType = ref.read(falTypeByNameAndDensityProvider(
          falName!.split(':').first,
          density: double.tryParse(densityInput.text)));
      falType ??= await createNewFalType(
          falName!,
          double.tryParse(densityInput.text)!,
          FALCategory.fromName(categoryInput.text));
      final outcome = FAL(
        uuid: const Uuid().v4(),
        falType: falType,
        amountLtrs: double.tryParse(_amountLtrsInput.text)!,
      );
      outcomesRepo.addOutcome(fal: outcome);
      outcomeDataSource.data.add(outcome);
      outcomeDataSource.updateDataGridRows();
      outcomeDataSource.updateDataGridSource();
    });
  }

  @override
  Widget build(BuildContext context) {
    final outcomes = ref.watch(outcomesRepositoryProvider);
    final outcomesRepo = ref.watch(outcomesRepositoryProvider.notifier);
    final outcomeDataSource =
        OutcomeDataSource(data: outcomes, outcomesRepo: outcomesRepo);
    final falTypesState = ref.watch(falTypesRepositoryProvider);
    return switch (falTypesState) {
      AsyncData(:final value) => Column(
          children: [
            SfDataGrid(
              source: outcomeDataSource,
              columnWidthMode: ColumnWidthMode.fill,
              allowEditing: true,
              editingGestureType: EditingGestureType.tap,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              footer: DataGridFooterWidget(
                text: 'Додати нову витрату',
                onPressed: () => _addNewOutcomePressed(
                    context, value, outcomesRepo, outcomeDataSource),
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
                  columnName: 'amountLtrs',
                  labelText: 'Кількість(л)',
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
                controller: _amountLtrsInput,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
                ],
                validator: validateNotEmpty,
                decoration: const InputDecoration(
                    icon: Icon(Icons.local_gas_station),
                    labelText: 'Залишок'))),
      ],
    );
  }
}
