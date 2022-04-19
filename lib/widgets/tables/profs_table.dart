import 'package:flutter/material.dart';
import 'package:notas/model/aluno.dart';
import 'package:notas/model/prof.dart';

class ProfsTable extends StatelessWidget{

  List<Prof> profs;
  final Function(Prof) selectChanged;
  int selected = 0;

  ProfsTable(this.profs, this.selectChanged, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      /*backgroundColor: Colors.blueAccent,
      foreground: Paint()
        ..color = Colors.white,*/
    );
    List<_Row> rl = [];
    for(Prof p in profs){
      _Row r = _Row(p.id, p.nome, p.email);
      if(p.id == selected){
        r.selected = true;
      }
      rl.add(r);
    }
    return PaginatedDataTable(
      showCheckboxColumn: false,
      columns:[
        DataColumn(label: Text('ID', style: boldStyle)),
        DataColumn(label: Text('NOME', style: boldStyle)),
        DataColumn(label: Text('EMAIL', style: boldStyle)),
      ],
      source: _DataSource(context, rl, selectedAluno),
    );
  }

  void selectedAluno(int id){
    for(Prof p in profs){
      if(p.id == id){
        selected = id;
        selectChanged(p);
        break;
      }
    }
  }
}

class _Row {
  _Row(
      this.A,
      this.B,
      this.C,
      );

  final int A;
  final String B;
  final String C;

  bool selected = false;
}

class _DataSource extends DataTableSource {

  final BuildContext context;
  final List<_Row> _rows;
  final int _selectedCount = 0;
  final Function(int) selectedAluno;

  _DataSource(this.context, this._rows, this.selectedAluno);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          /*_selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);*/
          for(_Row r in _rows){
            r.selected = false;
          }
          row.selected = value!;
          selectedAluno(row.A);
          notifyListeners();
        }
      },
      cells: [
        DataCell(Center(
          child: Text('${row.A}'),
        )),
        DataCell(Text(row.B)),
        DataCell(Center(
          child: Text(row.C),
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
