import 'package:notas/model/disc.dart';
import 'package:notas/model/pagina.dart';
import 'package:notas/model/prof.dart';
import 'package:notas/model/turma.dart';

class Aluno{
  final int matricula;
  final String nome;
  Turma turma;
  Prof? tutor;
  final Map<Disc, Pagina> paginas = {};


  Aluno(this.matricula, this.nome, this.turma, this.tutor);

  List<Pagina> listPaginas(){
    return paginas.values.toList();
  }

  Pagina? getPagina(Disc d){
    return paginas[d];
  }

  void addPagina(Pagina p){
    paginas[p.diario.disc] = p;
  }

  void deletePagina(Pagina p){
    paginas.remove(p.diario.disc);
  }
}