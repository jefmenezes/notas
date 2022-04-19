import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notas/model/data.dart';
import 'package:notas/model/disc.dart';
import 'package:notas/model/prof.dart';

import '../model/turma.dart';

class AddDiscWidget extends StatefulWidget {

  final Turma turma;
  final Data data;

  const AddDiscWidget(this.turma, this.data, {Key? key})
      : super(key: key);

  @override
  _AddDiscWidget createState() => _AddDiscWidget();
}


class _AddDiscWidget extends State<AddDiscWidget>{

  late Disc seldisc;
  late Prof selprof;

  @override
  void initState() {
    seldisc = widget.data.listDiscs()[0];
    selprof = widget.data.listProfs()[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final ButtonStyle bstyle = ElevatedButton.styleFrom(fixedSize: const Size(100, 20));
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
      width: 400,
      child: Column(
        children: [
          Row(
            children: [
              Text('Disciplina: '),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButton<Disc>(
                    value: seldisc,
                    items: widget.data.listDiscs().map<DropdownMenuItem<Disc>>((Disc d){
                      return DropdownMenuItem(
                        value: d,
                        child: Text(d.nome),
                      );
                    }).toList(),
                    onChanged: (Disc? newValue) {
                      setState(() {
                        seldisc = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('Professor:'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DropdownButton<Prof>(
                    value: selprof,
                    items: widget.data.listProfs().map<DropdownMenuItem<Prof>>((Prof p){
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.nome),
                      );
                    }).toList(),
                    onChanged: (Prof? newValue) {
                      setState(() {
                        selprof = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              style: bstyle,
              onPressed: () async {
                bool ok = await widget.data.addDisc(d)
                if(ok){
                  setState(() {
                    //ttable = TurmaTable(_turmas, setSelectedTurma);
                  });
                }
              },
              child: const Text('Remover')
          ),
        ],
      ),
    );
  }


}