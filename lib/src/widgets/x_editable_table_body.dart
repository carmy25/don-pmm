import 'package:flutter/material.dart';
import 'package:flutter_editable_table/constants.dart';
import 'package:flutter_editable_table/entities/row_entity.dart';

import 'x_editable_table_row.dart';

class XEditableTableBody extends StatefulWidget {
  const XEditableTableBody({
    Key? key,
    required this.bodyEntity,
    this.removable = false,
    required this.rowWidth,
    this.rowBorder,
    this.cellTextStyle,
    this.cellContentPadding,
    this.cellHintTextStyle,
    this.cellInputDecorationContentPadding,
    this.cellInputDecorationBorder,
    this.cellInputDecorationFocusBorder,
    this.removeRowIcon,
    this.removeRowIconPadding,
    this.removeRowIconAlignment,
    this.removeRowIconContainerBackgroundColor,
    this.formFieldAutoValidateMode,
    this.readOnly = false,
    this.onRowRemoved,
    this.onFilling,
    this.onSubmitted,
  }) : super(key: key);

  final List<RowEntity> bodyEntity;
  final bool removable;
  final double rowWidth;
  final Border? rowBorder;
  final TextStyle? cellTextStyle;
  final EdgeInsetsGeometry? cellContentPadding;
  final TextStyle? cellHintTextStyle;
  final EdgeInsetsGeometry? cellInputDecorationContentPadding;
  final InputBorder? cellInputDecorationBorder;
  final InputBorder? cellInputDecorationFocusBorder;
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
  XEditableTableBodyState createState() => XEditableTableBodyState();
}

class XEditableTableBodyState extends State<XEditableTableBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.bodyEntity
          .map(
            (row) => XEditableTableRow(
              rowEntity: row,
              removable: widget.removable,
              rowWidth: widget.rowWidth,
              rowBorder: widget.rowBorder,
              cellContentPadding: widget.cellContentPadding,
              cellInputDecorationContentPadding:
                  widget.cellInputDecorationContentPadding,
              cellHintTextStyle: widget.cellHintTextStyle,
              cellInputDecorationBorder: widget.cellInputDecorationBorder,
              cellInputDecorationFocusBorder:
                  widget.cellInputDecorationFocusBorder,
              cellTextStyle: widget.cellTextStyle,
              removeRowIcon: widget.removeRowIcon,
              removeRowIconPadding: widget.removeRowIconPadding,
              removeRowIconAlignment: widget.removeRowIconAlignment,
              removeRowIconContainerBackgroundColor:
                  widget.removeRowIconContainerBackgroundColor,
              formFieldAutoValidateMode: widget.formFieldAutoValidateMode,
              readOnly: widget.readOnly,
              onRowRemoved: widget.onRowRemoved,
              onFilling: widget.onFilling,
              onSubmitted: widget.onSubmitted,
            ),
          )
          .toList(),
    );
  }
}
