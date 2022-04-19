import 'package:flutter/material.dart';
import 'package:notas/model/aluno.dart';
import '../../model/turma.dart';

class AlunoTable extends StatelessWidget{

  List<Aluno> alunos;
  final Function(Aluno) selectChanged;
  int selected = 0;

  AlunoTable(this.alunos, this.selectChanged, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextStyle boldStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      /*backgroundColor: Colors.blueAccent,
      foreground: Paint()
        ..color = Colors.white,*/
    );
    List<_Row> rl = [];
    for(Aluno a in alunos){
      _Row r = _Row(a.matricula, a.nome, a.turma.toString());
      if(a.matricula == selected){
        r.selected = true;
      }
      rl.add(r);
    }
    return PaginatedDataTable(
      showCheckboxColumn: false,
      columns:[
        DataColumn(label: Text('MATRÍCULA', style: boldStyle)),
        DataColumn(label: Text('NOME', style: boldStyle)),
        DataColumn(label: Text('TURMA', style: boldStyle)),
      ],
      source: _DataSource(context, rl, selectedAluno),
    );
  }

  void selectedAluno(int matricula){
    for(Aluno a in alunos){
      if(a.matricula == matricula){
        selected = matricula;
        selectChanged(a);
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
