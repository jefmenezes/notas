import 'package:flutter/material.dart';
import 'package:notas/DAO/discDAO.dart';
import 'package:notas/model/data.dart';
import 'package:notas/widgets/tables/disc_table.dart';
import 'package:notas/widgets/tables/turmas_table.dart';
import '../DAO/turmaDAO.dart';
import '../model/disc.dart';
import '../providers/gsheets_provider.dart';

class Wdisciplinas extends StatefulWidget{

  final Data data;

  const Wdisciplinas({required this.data, Key? key,}) : super(key: key);

  @override
  _Wdisciplinas createState() => _Wdisciplinas();

}

class _Wdisciplinas extends State<Wdisciplinas>{

  final idctrl = TextEditingController();
  final nmtrl = TextEditingController();

  int id = 0;

  @override
  void initState(){
    /*getId().then((val) => setState(() {
      id = val;
    }));*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Disicplinas'),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Text('$id'),
              DiscTable(widget.data.listDiscs()),
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

}