import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/turma.dart';

class PesosWidget extends StatelessWidget{

  final Turma turma;

  PesosWidget(this.turma, {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController pavc = TextEditingController(text: '${turma.pAV}');
    TextEditingController psmc = TextEditingController(text: '${turma.pSM}');
    TextEditingController patc = TextEditingController(text: '${turma.pAT}');
    TextEditingController psec = TextEditingController(text: '${turma.pSE}');

    TextStyle boldStyle = const TextStyle(
      fontWeight: FontWeight.bold,
      /*backgroundColor: Colors.blueAccent,
      foreground: Paint()
        ..color = Colors.white,*/
    );
    /*List<_Row> rl = [];
    for(TurmaDAO t in turmas){
      _Row r = _Row(t.id, t.serie, t.turma);
      if(t.id == selected){
        r.selected = true;
      }
      rl.add(r);
    }*/
    return Container(
      height: 200,
      width: 200,
      child: Column(
        children: [
          Row(
            children: [
              Text('Peso da Avaliação: '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: pavc,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Peso do Simulado: '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: psmc,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Peso das Atividades: '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: patc,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Peso Socioemocional: '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: psec,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


}