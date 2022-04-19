import 'package:notas/DAO/alunoDAO.dart';
import 'package:notas/DAO/diarioDAO.dart';
import 'package:notas/DAO/discDAO.dart';
import 'package:notas/DAO/notaDAO.dart';
import 'package:notas/DAO/paginaDAO.dart';
import 'package:notas/model/aluno.dart';
import 'package:notas/model/nota.dart';
import 'package:notas/model/pagina.dart';
import 'package:notas/model/prof.dart';
import 'package:notas/model/turma.dart';
import 'package:notas/providers/gsheets_provider.dart';

import '../DAO/profDAO.dart';
import '../DAO/turmaDAO.dart';
import 'diario.dart';
import 'disc.dart';

class Data{

  GSheetsProvider _provider;
  final Map<int, Turma> turmas = {};
  final Map<int, Aluno> alunos = {};
  final Map<int, Prof> profs = {};
  final Map<int, Disc> discs = {};
  final Map<int, Diario> diarios = {};
  final Map<int, Pagina> paginas = {};
  final Map<int, Nota> notas = {};

  Data(this._provider);

  Future<List<NotaDAO>> load() async{
    List<NotaDAO> ntsd = [];
    List<TurmaDAO> tmsd = [];
    List<AlunoDAO> alsd = [];
    List<ProfDAO> pfsd = [];
    List<DiscDAO> dcsd = [];
    List<DiarioDAO> drsd = [];
    List<PaginaDAO> pgsd = [];

    ntsd = await _provider.listNotas();
    tmsd = await _provider.listTurmas();
    alsd =  await _provider.listAlunos();
    pfsd = await _provider.listProfs();
    dcsd = await _provider.listDics();
    drsd = await _provider.listDiarios();
    pgsd = await _provider.listPaginas();

    for(NotaDAO ntd in ntsd){
      Nota n = Nota(ntd.AV, ntd.AT, ntd.SM, ntd.SE);
      notas[ntd.id] = n;
    }

    for(TurmaDAO tmd in tmsd){
      Turma t = Turma(tmd.id, tmd.serie, tmd.turma, tmd.pAV, tmd.pSM, tmd.pAT, tmd.pSE);
      turmas[tmd.id] = t;
    }

    for(AlunoDAO ald in alsd){
      Turma t = turmas[ald.idturma]!;
      Aluno a = Aluno(ald.id, ald.nome, turmas[ald.idturma]!, profs[ald.idtutor]);
      alunos[ald.id] = a;
      t.addAluno(a);
    }

    for(ProfDAO pfd in pfsd){
      Prof p = Prof(pfd.id, pfd.nome, pfd.email);
      profs[pfd.id] = p;
    }

    for(DiscDAO dcd in dcsd){
      Disc d = Disc(dcd.id, dcd.nome);
      discs[dcd.id] = d;
    }

    for(DiarioDAO drd in drsd){
      Turma t = turmas[drd.idturma]!;
      Prof p = profs[drd.idprof]!;
      Disc dc = discs[drd.iddisc]!;
      Diario d = Diario(t, p, dc);
      diarios[drd.id] = d;
      t.addDiario(d);
      p.addDiario(d);
      dc.addDiario(d);
    }

    for(PaginaDAO pgd in pgsd){
      Diario d = diarios[pgd.iddiario]!;
      Aluno a = alunos[pgd.idaluno]!;
      Nota n1 = notas[pgd.idn1]!;
      Nota n2 = notas[pgd.idn2]!;
      Nota n3 = notas[pgd.idn3]!;
      Nota n4 = notas[pgd.idn4]!;
      Pagina p = Pagina(d, a, n1, n2, n3, n4);
      paginas[pgd.id] = p;
      d.addPagina(p);
      a.addPagina(p);
    }


    return ntsd;
  }


  List<Turma> listTurmas(){
    return turmas.values.toList();
  }

  Future<bool> addTurma(Turma t) async{
    TurmaDAO td = TurmaDAO(id: t.id, serie: t.serie, turma: t.turma, pAV: t.pAV, pSM: t.pSM, pAT: t.pAT, pSE: t.pSE);
    bool result = await _provider.addTurma(td);
    if(result){
      turmas[t.id] = t;
    }
    return result;
  }

  Future<bool> addDiscTurma(Turma t, Disc d, Prof? p) async{
    DiarioDAO dd = DiarioDAO(id: getNewDiarioID(), idturma: t.id, idprof: p!.id, iddisc: d.id);
    List<PaginaDAO> pgsd = [];
    List<NotaDAO> ntsd = [];

    for(Aluno a in t.listAlunos()){
      int pid = getNewPaginaID();
      NotaDAO n1 = NotaDAO(id: getNewNotaID(), idpagina: pid);
      notas[n1.id] = Nota(0, 0, 0, 0);
      ntsd.add(n1);
      NotaDAO n2 = NotaDAO(id: getNewNotaID(), idpagina: pid);
      notas[n2.id] = Nota(0, 0, 0, 0);
      ntsd.add(n2);
      NotaDAO n3 = NotaDAO(id: getNewNotaID(), idpagina: pid);
      notas[n3.id] = Nota(0, 0, 0, 0);
      ntsd.add(n3);
      NotaDAO n4 = NotaDAO(id: getNewNotaID(), idpagina: pid);
      notas[n4.id] = Nota(0, 0, 0, 0);
      ntsd.add(n4);
      PaginaDAO pd = PaginaDAO(id: pid, iddiario: dd.id, idaluno: a.matricula, idn1: n1.id, idn2: n2.id, idn3: n3.id, idn4: n4.id);
      pgsd.add(pd);
    }
    TurmaDAO td = TurmaDAO(id: t.id, serie: t.serie, turma: t.turma, pAV: t.pAV, pSM: t.pSM, pAT: t.pAT, pSE: t.pSE);
    bool result = await _provider.addTurma(td);
    if(result){
      turmas[t.id] = t;
    }
    return result;
  }

  Future<bool> deleteTurma(Turma t) async{
    TurmaDAO td = TurmaDAO(id: t.id, serie: t.serie, turma: t.turma, pAV: t.pAV, pSM: t.pSM, pAT: t.pAT, pSE: t.pSE);
    bool result = await _provider.deleteTurma(td);
    if(result){
      turmas.remove(t.id);
    }
    return result;
  }

  int getNewTurmaID(){
    int result = 0;
    while(true){
      result++;
      if(!turmas.containsKey(result)){
        return result;
      }
    }
  }




  Future<void> loadProfs() async{
    List<ProfDAO> profs = await _provider.listProfs();
    for(ProfDAO p in profs){
      profs[p.id] = p;
    }
  }

  List<Prof> listProfs(){
    return profs.values.toList();
  }

  Future<bool> addProf(ProfDAO p) async{
    bool result = await _provider.addProf(p);
    if(result){
      Prof pf = Prof(p.id, p.nome, p.email);
      profs[p.id] = pf;
    }
    return result;
  }

  Future<bool> deleteProf(ProfDAO p) async{
    bool result = await _provider.deleteProf(p);
    if(result){
      profs.remove(p.id);
    }
    return result;
  }



  Future<void> loadDisc() async {
    List<DiscDAO> discs = await _provider.listDics();
    for(DiscDAO d in discs){
      discs[d.id] = d;
    }
  }

  List<Disc> listDiscs(){
    return discs.values.toList();
  }

  Future<bool> addDisc(Disc d) async{
    DiscDAO dd = DiscDAO(id: d.id, nome: d.nome);
    bool result = await _provider.addDisc(dd);
    if(result){
      Disc dc = Disc(d.id, d.nome);
      discs[d.id] = dc;
    }
    return result;
  }

  Future<bool> deleteDisc(Disc d) async{
    DiscDAO dd = DiscDAO(id: d.id, nome: d.nome);
    bool result = await _provider.deleteDisc(dd);
    if(result){
      discs.remove(d.id);
    }
    return result;
  }

  int getNewDiscID(){
    int result = 0;
    while(true){
      result++;
      if(!discs.containsKey(result)){
        return result;
      }
    }
  }


  int getNewDiarioID(){
    int result = 0;
    while(true){
      result++;
      if(!diarios.containsKey(result)){
        return result;
      }
    }
  }

  int getNewPaginaID(){
    int result = 0;
    while(true){
      result++;
      if(!paginas.containsKey(result)){
        return result;
      }
    }
  }

  int getNewNotaID(){
    int result = 0;
    while(true){
      result++;
      if(!notas.containsKey(result)){
        return result;
      }
    }
  }



  List<Aluno> listAlunos(){
    return alunos.values.toList();
  }

}