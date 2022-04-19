import 'package:notas/model/aluno.dart';
import 'package:notas/model/diario.dart';
import 'package:notas/model/disc.dart';

class Prof{
  final int id;
  final String nome;
  final String email;
  Map<Disc, Diario> diarios = {};
  Map<int, Aluno> tutorandos = {};

  Prof(this.id, this.nome, this.email);

  List<Diario> listDiarios(){
    return diarios.values.toList();
  }

  Diario? getDiario(Disc d){
    return diarios[d];
  }

  void addDiario(Diario d){
    diarios[d.disc] = d;
  }

  void deleteDiario(Diario d){
    diarios.remove(d.disc);
  }

  List<Aluno> listTutorandos(){
    return tutorandos.values.toList();
  }

  Aluno? getTutorando(int id){
    return tutorandos[id];
  }

  void addTutorando(Aluno a){
    tutorandos[a.matricula] = a;
  }

  void deleteTutorando(Aluno a){
    tutorandos.remove(a.matricula);
  }
}