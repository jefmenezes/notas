import 'package:notas/model/diario.dart';
import 'package:notas/model/turma.dart';

class Disc{
  final int id;
  final String nome;
  final Map<Turma, Diario> diarios = {};

  Disc(this.id, this.nome);

  List<Diario> listDiarios(){
    return diarios.values.toList();
  }

  Diario? getDiario(Turma t){
    return diarios[t];
  }

  void addDiario(Diario d){
    diarios[d.turma] = d;
  }

  void deleteDiario(Diario d){
    diarios.remove(d.turma);
  }
}