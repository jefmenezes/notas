import 'package:flutter/material.dart';
import '../model/turma.dart';

class TurmaTable extends StatelessWidget{

  List<Turma> turmas;
  final Function(Turma) selectChanged;
  int selected = 0;

  TurmaTable(this.turmas, this.selectChanged, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      /*backgroundColor: Colors.blueAccent,
      foreground: Paint()
        ..color = Colors.white,*/
    );
    List<_Row> rl = [];
    for(Turma t in turmas){
      _Row r = _Row(t.id, t.serie, t.turma);
      if(t.id == selected){
        r.selected = true;
      }
      rl.add(r);
    }
    return PaginatedDataTable(
      showCheckboxColumn: false,
      columns:[
        DataColumn(label: Text('ID', style: boldStyle)),
        DataColumn(label: Text('SÉRIE', style: boldStyle)),
        DataColumn(label: Text('TURMA', style: boldStyle)),
      ],
      source: _DataSource(context, rl, selectedTurma),
    );
  }

  void selectedTurma(int id){
    for(Turma t in turmas){
      if(t.id == id){
        selected = id;
        selectChanged(t);
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
  final int B;
  final String C;

  bool selected = false;
}

class _DataSource extends DataTableSource {

  final BuildContext context;
  final List<_Row> _rows;
  final int _selectedCount = 0;
  final Function(int) selectedTurma;

  _DataSource(this.context, this._rows, this.selectedTurma);

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
          selectedTurma(row.A);
          notifyListeners();
        }
      },
      cells: [
        DataCell(Center(
          child: Text('${row.A}'),
        )),
        DataCell(Center(
          child: Text('${row.B}'),
        )),
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
