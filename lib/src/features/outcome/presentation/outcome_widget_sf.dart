import 'package:donpmm/src/common/datagrid_source.dart';
import 'package:donpmm/src/features/fal/domain/fal.dart';
import 'package:donpmm/src/features/outcome/data/outcomes_repository.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
