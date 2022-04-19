import 'package:flutter/material.dart';
import 'package:notas/model/data.dart';
import 'package:notas/widgets/set_pesos.dart';
import 'package:notas/widgets/turmas_table.dart';
import '../DAO/turmaDAO.dart';
import '../model/turma.dart';

class Wturmas extends StatefulWidget{

  final Data data;

  const Wturmas({required this.data, Key? key,}) : super(key: key);

  @override
  _Wturmas createState() => _Wturmas();

}

class _Wturmas extends State<Wturmas>{

  int id = 0;
  late TurmaTable ttable;
  Turma? selected;

  void setSelectedTurma(Turma t){
    selected = t;
    setState(() {

    });
    //print(selected!.turma);
  }

  @override
  void initState(){
    /*getId().then((val) => setState(() {
      id = val;
      ttable = TurmaTable(_turmas, setSelectedTurma);
    }));*/
    /*loadTurmas().then((value) => setState(() {
      ttable = TurmaTable(_turmas, setSelectedTurma);
    }));*/
    ttable = TurmaTable(widget.data.listTurmas(), setSelectedTurma);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ttable.turmas = _turmas;
    final ButtonStyle bstyle = ElevatedButton.styleFrom(fixedSize: const Size(100, 20));
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Turmas'),
          ),
        ),
        body: Row(
          children: [
            Container(
              width: 300,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('$id'),
                  widget.data.listTurmas().isEmpty ? Container() : ttable,
                ],
              ),
            ),
            Container(
              width: 100,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: bstyle,
                    onPressed: () {
                      showCustomDialog(context);
                    },
                    child: const Text('Adicionar')
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: bstyle,
                    onPressed: () {},
                    child: const Text('Editar')
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: bstyle,
                    onPressed: selected==null ? null : () async {
                      bool ok = await deleteTurma(selected!);
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
            ),
            //PesosWidget(turmas)
          ],
        )

    );
  }

  Future<bool> addTurma(Turma t) async{
    bool result = await widget.data.addTurma(t);
    if(result) {
      ttable = TurmaTable(widget.data.listTurmas(), setSelectedTurma);
    }
    return result;
  }

  Future<bool> deleteTurma(Turma t) async {
    bool ok = await widget.data.deleteTurma(t);
    if(ok){
      ttable = TurmaTable(widget.data.listTurmas(), setSelectedTurma);
    }
    return ok;
  }

  void showCustomDialog(BuildContext context) {
    final sctrl = TextEditingController();
    final tctrl = TextEditingController();
    id = widget.data.getNewTurmaID();
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 260,
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            //decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 300,
                  color: Colors.blueAccent,
                  child: const Center(
                    child: Text('ADICIONAR TURMA', style: TextStyle(fontSize: 20, color: Colors.white),)
                  ),
                ),
                Material(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Text('ID: '),
                            Text('$id'),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Série:'),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: sctrl,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Turma:'),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: tctrl,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () async {
                            //TurmaDAO t = TurmaDAO(id: id, serie: int.parse(sctrl.text), turma: tctrl.text, pAV: 1, pSM: 1, pAT: 1, pSE: 1);
                            Turma t = Turma(id, int.parse(sctrl.text), tctrl.text, 1, 1, 1, 1);
                            await addTurma(t);
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text('Adicionar'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

}