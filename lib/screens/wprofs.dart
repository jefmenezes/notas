import 'package:flutter/material.dart';
import 'package:notas/DAO/discDAO.dart';
import 'package:notas/model/data.dart';
import 'package:notas/widgets/tables/aluno_table.dart';
import 'package:notas/widgets/tables/disc_table.dart';
import 'package:notas/widgets/tables/turmas_table.dart';
import '../DAO/turmaDAO.dart';
import '../model/aluno.dart';
import '../model/disc.dart';
import '../model/prof.dart';
import '../providers/gsheets_provider.dart';
import '../widgets/tables/profs_table.dart';

class Wprofs extends StatefulWidget{

  final Data data;

  const Wprofs({required this.data, Key? key,}) : super(key: key);

  @override
  _Wprofs createState() => _Wprofs();

}

class _Wprofs extends State<Wprofs>{

  final idctrl = TextEditingController();
  final nmtrl = TextEditingController();

  int id = 0;
  Prof? selected;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Professores'),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Text('$id'),
              ProfsTable(widget.data.listProfs(), setSelectedProf),
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

  void setSelectedProf(Prof p){
    selected = p;
    setState(() {

    });
  }

}