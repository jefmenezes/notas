import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../model/disc.dart';

class DiscTable extends StatelessWidget{

  List<Disc> _discs = [];

  DiscTable(this._discs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = const TextStyle(fontWeight: FontWeight.bold);
    return PaginatedDataTable(
      columns:[
        DataColumn(label: Text('ID', style: boldStyle)),
        DataColumn(label: Text('DISCIPLINA', style: boldStyle)),
      ],
      source: _DataSource(context, _discs.map((e) => _Row(e.id, e.nome)).toList()),
    );
  }
}

class _Row {
  _Row(
      this.A,
      this.B,
      );

  final int A;
  final String B;

  bool selected = false;
}

class _DataSource extends DataTableSource {

  final BuildContext context;
  final List<_Row> _rows;
  int _selectedCount = 0;

  _DataSource(this.context, this._rows);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Center(
          child: Text('${row.A}'),
        )),
        DataCell(Center(
          child: Text(row.B),
        )),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
