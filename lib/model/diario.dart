import 'package:notas/model/aluno.dart';
import 'package:notas/model/disc.dart';
import 'package:notas/model/pagina.dart';
import 'package:notas/model/prof.dart';
import 'package:notas/model/turma.dart';

class Diario{
  final Turma turma;
  final Prof prof;
  final Disc disc;

  final Map<Aluno, Pagina> paginas = {};

  Diario(this.turma, this.prof, this.disc);

  List<Pagina> listPaginas(){
    return paginas.values.toList();
  }

  Pagina? getPagina(Aluno a){
    return paginas[a];
  }

  void addPagina(Pagina p){
    paginas[p.aluno] = p;
  }

  void deletePagina(Pagina p){
    paginas.remove(p.aluno);
  }
}