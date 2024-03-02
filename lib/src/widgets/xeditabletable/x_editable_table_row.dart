import 'package:donpmm/src/widgets/xeditabletable/x_editable_table_data_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/row_entity.dart';
import 'package:flutter_editable_table/widget/operation_cell.dart';

class XEditableTableRow extends StatefulWidget {
  const XEditableTableRow({
    super.key,
    required this.rowEntity,
    this.removable = false,
    required this.rowWidth,
    this.rowBorder,
    this.cellContentPadding,
    this.cellInputDecorationContentPadding,
    this.cellHintTextStyle,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
    this.cellTextStyle,
    this.removeRowIcon,
    this.removeRowIconPadding,
    this.removeRowIconAlignment,
    this.removeRowIconContainerBackgroundColor,
    this.formFieldAutoValidateMode,
    this.readOnly = false,
    this.onRowRemoved,
    this.onFilling,
    this.onSubmitted,
  });

  final RowEntity rowEntity;
  final bool removable;
  final double rowWidth;
  final Border? rowBorder;
  final EdgeInsetsGeometry? cellContentPadding;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final TextStyle? cellHintTextStyle;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
  final TextStyle? cellTextStyle;
  final Widget? removeRowIcon;
  final EdgeInsetsGeometry? removeRowIconPadding;
  final Alignment? removeRowIconAlignment;
  final Color? removeRowIconContainerBackgroundColor;
  final AutovalidateMode? formFieldAutoValidateMode;
  final bool readOnly;

  final ValueChanged<RowEntity>? onRowRemoved;
  final TableFiledFilled<dynamic>? onFilling;
  final TableFiledFilled<dynamic>? onSubmitted;

  @override
  XEditableTableRowState createState() => XEditableTableRowState();
}

class XEditableTableRowState extends State<XEditableTableRow> {
  @override
  Widget build(BuildContext context) {
    final actualWidth = (widget.rowWidth -
            (widget.removable ? 32.0 : 0.0) -
            (widget.rowBorder != null
                ? widget.rowBorder!.left.width + widget.rowBorder!.right.width
                : 0.0)) /
        widget.rowEntity.cells!
            .where((cell) => cell.columnInfo.display)
            .map((cell) => cell.columnInfo.widthFactor)
            .reduce((value, element) => value + element);
    return widget.removable
        ? SizedBox(
            width: widget.rowWidth,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRow(actualWidth),
                if (!widget.readOnly)
                  EditableTableOperationCell(
                    removeRowIcon: widget.removeRowIcon,
                    removeRowIconPadding: widget.removeRowIconPadding,
                    removeRowIconAlignment: widget.removeRowIconAlignment,
                    removeRowIconContainerBackgroundColor:
                        widget.removeRowIconContainerBackgroundColor,
                    onRowRemoved: () {
                      if (widget.onRowRemoved != null) {
                        widget.onRowRemoved!(widget.rowEntity);
                      }
                    },
                  ),
              ],
            ),
          )
        : _buildRow(actualWidth);
  }

  Widget _buildRow(double rowWidth) {
    return Container(
      width: widget.rowWidth - (widget.removable ? 32.0 : 0.0),
      decoration: BoxDecoration(
        border: widget.rowBorder != null
            ? Border(
                left: widget.rowBorder!.left,
                right: widget.rowBorder!.right,
                bottom: widget.rowBorder!.bottom,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.rowEntity.cells!
            .where((cell) => cell.columnInfo.display)
            .map(
              (cell) => XEditableTableDataCell(
                cellEntity: cell,
                cellWidth: cell.columnInfo.widthFactor * rowWidth,
                cellContentPadding: widget.cellContentPadding,
                cellInputDecorationContentPadding:
                    widget.cellInputDecorationContentPadding,
                cellHintTextStyle: widget.cellHintTextStyle,
                cellInputDecorationBorder: widget.cellInputDecorationBorder,
                cellInputDecorationFocusBorder:
                    widget.cellInputDecorationFocusBorder,
                cellTextStyle: widget.cellTextStyle,
                formFieldAutoValidateMode: widget.formFieldAutoValidateMode,
                readOnly: widget.readOnly,
                onFilling: widget.onFilling,
                onSubmitted: widget.onSubmitted,
              ),
            )
            .toList(),
      ),
    );
  }
}
