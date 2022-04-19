import 'package:notas/model/aluno.dart';
import 'package:notas/model/diario.dart';
import 'package:notas/model/disc.dart';

class Turma{
  final int id;
  final int serie;
  final String turma;
  final int pAV;
  final int pSM;
  final int pAT;
  final int pSE;
  final Map<Disc, Diario> diarios = {};
  final Map<int, Aluno> alunos = {};


  Turma(this.id, this.serie, this.turma, this.pAV, this.pSM, this.pAT, this.pSE);

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

  List<Aluno> listAlunos(){
    return alunos.values.toList();
  }

  Aluno? getAluno(int id){
    return alunos[id];
  }

  void addAluno(Aluno a){
    alunos[a.matricula] = a;
  }

  void deleteAluno(int id){
    alunos.remove(id);
  }

  String toString(){
    return '$serie'+turma;
  }

}