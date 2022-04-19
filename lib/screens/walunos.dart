import 'package:flutter/material.dart';
import 'package:notas/DAO/discDAO.dart';
import 'package:notas/model/data.dart';
import 'package:notas/widgets/tables/aluno_table.dart';
import 'package:notas/widgets/tables/disc_table.dart';
import 'package:notas/widgets/tables/turmas_table.dart';
import '../DAO/turmaDAO.dart';
import '../model/aluno.dart';
import '../model/disc.dart';
import '../providers/gsheets_provider.dart';

class Walunos extends StatefulWidget{

  final Data data;

  const Walunos({required this.data, Key? key,}) : super(key: key);

  @override
  _Walunos createState() => _Walunos();

}

class _Walunos extends State<Walunos>{

  final idctrl = TextEditingController();
  final nmtrl = TextEditingController();

  int id = 0;
  Aluno? selected;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Alunos'),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Text('$id'),
              AlunoTable(widget.data.listAlunos(), setSelectedAluno),
              TextField(
                controller: idctrl,
              ),
              TextField(
                controller: nmtrl,
              ),
              TextButton(
                onPressed: () async {
                  Disc d = Disc(int.parse(idctrl.text), nmtrl.text);
                  await widget.data.addDisc(d);
                  setState(() {

                  });
                },
                child: Text('Adicionar'),
              )
            ],
          ),
        )

    );
  }

  void setSelectedAluno(Aluno a){
    selected = a;
    setState(() {

    });
  }

}