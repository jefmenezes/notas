import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas/DAO/turmaDAO.dart';
import 'package:notas/model/data.dart';
import 'package:notas/screens/walunos.dart';
import 'package:notas/screens/wdisciplinas.dart';
import 'package:notas/screens/wprofs.dart';
import 'package:notas/screens/wturmas.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import '../providers/gsheets_provider.dart';

class MainWindow extends StatefulWidget {
  final Data data;
  const MainWindow({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  _MainWindow createState() => _MainWindow();
}

class _MainWindow extends State<MainWindow> {

  @override
  Widget build(BuildContext context) {
    //widget.provider.addTurma(Turma(id: 100, serie: 2, turma: 'F'));
      return VerticalTabs(
          tabsWidth: 150,
          tabs: const <Tab>[
            Tab(child: Text('Turmas'), icon: Icon(Icons.phone)),
            Tab(child: Text('Professores'), icon: Icon(Icons.phone)),
            Tab(child: Text('Disciplinas'), icon: Icon(Icons.phone)),
            Tab(child: Text('Alunos'), icon: Icon(Icons.phone)),
          ],
          contents: <Widget>[
            Wturmas(data: widget.data),
            Wprofs(data: widget.data),
            Wdisciplinas(data: widget.data),
            Walunos(data: widget.data),
          ]
      );
  }

}