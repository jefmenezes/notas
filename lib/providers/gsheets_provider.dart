
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:gsheets/gsheets.dart';
import 'package:notas/DAO/alunoDAO.dart';
import 'package:notas/DAO/diarioDAO.dart';
import 'package:notas/DAO/discDAO.dart';
import 'package:notas/DAO/notaDAO.dart';
import 'package:notas/DAO/paginaDAO.dart';
import 'package:notas/DAO/profDAO.dart';

import '../DAO/turmaDAO.dart';

class GSheetsProvider {
  final GSheets _gsheets;
  //final GoogleSignIn _signin;

  late Spreadsheet _excel;
  //late Worksheet _worksheet;

  GSheetsProvider(String credentials) : _gsheets = GSheets(credentials);

  Future<void> initializeForWorksheet(String spreadsheetId, String worksheetTitle) async {
    _excel = await _gsheets.spreadsheet(spreadsheetId);
    /*for(Worksheet ws in _excel.sheets){
      print(ws.title);
    }*/
    // get worksheet by its title
   // var sheet = _excel.worksheetByTitle('example');
    // create worksheet if it does not exist yet
   // sheet ??= await _excel.addWorksheet('example');


    //_worksheet = excel.worksheetByTitle(worksheetTitle)!;
  }

  Future<bool> addTurma(TurmaDAO t) async{
    //print('teste');
    Worksheet sheet = _excel.worksheetByTitle('Turmas')!;

    final values = (await sheet.values.allRows()).skip(1).toList();
    List<TurmaDAO> turmas = values.map((value) => TurmaDAO.fromSheets(value)).toList();

    for(TurmaDAO tm in turmas){
      if(t.equals(tm)){
        return false;
      }
    }

    return await sheet.values.appendRow([t.id, t.serie, t.turma]);
  }

  Future<bool> deleteTurma(TurmaDAO t) async{
    Worksheet? sheet = _excel.worksheetByTitle('Turmas');
    if(sheet==null) return false;

    final index = await sheet.values.rowIndexOf(t.id);
    if(index < 0) return false;
    return await sheet.deleteRow(index);
  }

  Future<List<TurmaDAO>> listTurmas() async {
    Worksheet _worksheet = _excel.worksheetByTitle("Turmas")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => TurmaDAO.fromSheets(value)).toList();
  }



  Future<bool> addDisc(DiscDAO d) async{
    Worksheet? sheet = _excel.worksheetByTitle('Disciplinas');
    return await sheet!.values.appendRow([d.id, d.nome]);
  }

  Future<List<DiscDAO>> listDics() async {
    Worksheet _worksheet = _excel.worksheetByTitle('Disciplinas')!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => DiscDAO.fromSheets(value)).toList();
  }

  Future<bool> deleteDisc(DiscDAO d) async{
    Worksheet? sheet = _excel.worksheetByTitle('Disciplinas');
    if(sheet==null) return false;

    final index = await sheet.values.rowIndexOf(d.id);
    if(index < 0) return false;
    return await sheet.deleteRow(index);
  }



  Future<List<ProfDAO>> listProfs() async {
    Worksheet _worksheet = _excel.worksheetByTitle("Professores")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => ProfDAO.fromSheets(value)).toList();
  }

  Future<bool> addProf(ProfDAO p) async {
    Worksheet sheet = _excel.worksheetByTitle('Professores')!;

    final values = (await sheet.values.allRows()).skip(1).toList();
    return await sheet.values.appendRow([p.id, p.nome]);
  }

  Future<bool> deleteProf(ProfDAO p) async{
    Worksheet? sheet = _excel.worksheetByTitle('Professores');
    if(sheet==null) return false;

    final index = await sheet.values.rowIndexOf(p.id);
    if(index < 0) return false;
    return await sheet.deleteRow(index);
  }



  Future<List<AlunoDAO>> listAlunos() async {
    Worksheet _worksheet = _excel.worksheetByTitle("Alunos")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => AlunoDAO.fromSheets(value)).toList();
  }




  Future<List<DiarioDAO>> listDiarios() async {
    Worksheet _worksheet = _excel.worksheetByTitle("Diarios")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => DiarioDAO.fromSheets(value)).toList();
  }




  Future<List<PaginaDAO>> listPaginas() async {
    Worksheet _worksheet = _excel.worksheetByTitle("Paginas")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => PaginaDAO.fromSheets(value)).toList();
  }




  Future<List<NotaDAO>> listNotas() async {
    Worksheet _worksheet = _excel.worksheetByTitle("Notas")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => NotaDAO.fromSheets(value)).toList();
  }




 /* Future<bool> addDiario(DiarioDAO d) async{
   /* var sheet = _excel.worksheetByTitle('example');
    sheet ??= await _excel.addWorksheet('example');*/
    Worksheet sheet = _excel.worksheetByTitle('Diarios')!;
    return await sheet.values.appendRow([d.id, d.nome]);
  }*/

  /*Future<List<DiscDAO>> listDics() async {
    Worksheet _worksheet = _excel.worksheetByTitle('Disciplinas')!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => DiscDAO.fromSheets(value)).toList();
  }*/

  /*Future<bool> deleteDisc(DiscDAO d) async{
    Worksheet? sheet = _excel.worksheetByTitle('Disciplinas');
    if(sheet==null) return false;

    final index = await sheet.values.rowIndexOf(d.id);
    if(index < 0) return false;
    return await sheet.deleteRow(index);
  }*/

  /*GoogleSignInAccount? getUser(){
    return _signin.currentUser;
  }

  Future<void> signOut() => _signin.disconnect();

  /*Future<List<HouseEntity>> getHouses() async {
    /// skips the first value which is the header
    /// final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => HouseEntity.fromSheets(value)).toList();
  }*/

  /*Future<bool> deleteHouse(int index) {
    /// We add one to the index so that we can:
    /// 1. Start at index 1
    /// 2. Skip the first row
    return _worksheet.deleteRow(index + 2);
  }*/

  /*Future<bool> addHouse(String name, String address) {
    return _worksheet.values.appendRow([name, address]);
  }*/

  Future<List<Eletiva>> getEletivas() async {
    Worksheet _worksheet = _excel.worksheetByTitle("eletiva")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => Eletiva.fromSheets(value)).toList();
  }

  Future<bool> deleteEletiva(int index) {
    /// We add one to the index so that we can:
    /// 1. Start at index 1
    /// 2. Skip the first row
    Worksheet _worksheet = _excel.worksheetByTitle("eletiva")!;
    return _worksheet.deleteRow(index + 2);
  }

  Future<bool> addEletiva(int id, String nome, String imgurl, String desc, int limite, String turma) {
    Worksheet _worksheet = _excel.worksheetByTitle("eletiva")!;
    return _worksheet.values.appendRow([id, nome, imgurl, desc, limite, turma]);
  }

  Future<List<Aluno>> getAlunos() async {
    Worksheet _worksheet = _excel.worksheetByTitle("aluno")!;
    /// skips the first value which is the header
    final values = (await _worksheet.values.allRows()).skip(1).toList();
    return values.map((value) => Aluno.fromSheets(value)).toList();
  }

  Future<bool> deleteAluno(int index) {
    /// We add one to the index so that we can:
    /// 1. Start at index 1
    /// 2. Skip the first row
    Worksheet _worksheet = _excel.worksheetByTitle("aluno")!;
    return _worksheet.deleteRow(index + 2);
  }

  Future<bool> addAluno(String nome, String email, int Eletiva) {
    Worksheet _worksheet = _excel.worksheetByTitle("aluno")!;
    return _worksheet.values.appendRow([email, nome, Eletiva]);
  }

  Future<bool> addAluno2() {
    Worksheet _worksheet = _excel.worksheetByTitle("aluno")!;
    return _worksheet.values.appendRow([getUser()!.email, getUser()!.displayName, 0, 'z', 0]);
  }

  Future<bool> updateAluno(String email, int eletiva) async{
    List<Aluno> alns = await getAlunos();
    List<Eletiva> tt = await getEletivas();
    int max = 0;
    for(Eletiva t in tt){
      if(t.id==eletiva){
        max = t.limite;
        break;
      }
    }
    int at = 0;
    for(Aluno a in alns){
      if(a.eletiva==eletiva){
        at++;
      }
    }
    if(at<max) {
      Worksheet _worksheet = _excel.worksheetByTitle("aluno")!;
      return _worksheet.values.insertValueByKeys(
          eletiva, columnKey: 'ELETIVA', rowKey: email);
    }
    return false;
  }*/

}
