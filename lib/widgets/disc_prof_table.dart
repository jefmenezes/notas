import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:notas/model/disc.dart';
import 'package:notas/model/prof.dart';

import '../DAO/discDAO.dart';
import '../model/diario.dart';

class DiscProfTable extends StatelessWidget{

  List<Diario> _diarios = [];

  DiscProfTable(this._diarios, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = const TextStyle(fontWeight: FontWeight.bold);
    return PaginatedDataTable(
      columns:[
        DataColumn(label: Text('DISCIPLINA', style: boldStyle)),
        DataColumn(label: Text('PROFESSOR', style: boldStyle)),
      ],
      source: _DataSource(context, _diarios.map((e) => _Row(e.disc, e.prof)).toList()),
    );
  }
}

class _Row {
  _Row(
      this.A,
      this.B,
      );

  final Disc A;
  final Prof B;

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
          child: Text(row.A.nome),
        )),
        DataCell(Center(
          child: Text(row.B.nome),
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
