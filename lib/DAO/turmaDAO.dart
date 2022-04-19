class TurmaDAO{
  final int id;
  final int serie;
  final String turma;
  final int pAV;
  final int pSM;
  final int pAT;
  final int pSE;

  TurmaDAO({
    required this.id,
    required this.serie,
    required this.turma,
    required this.pAV,
    required this.pSM,
    required this.pAT,
    required this.pSE,
  });

  /*factory TurmaDAO.fromSheets(List<String> input) =>
      TurmaDAO(id: int.parse(input[0]), serie: int.parse(input[1]), turma: input[2], pAV: int.parse(input[3]), pSM: int.parse(input[4]), pAT: int.parse(input[5]), pSE: int.parse(input[6]));
   */

  factory TurmaDAO.fromSheets(List<String> input){
    int id = int.parse(input[0]);
    int serie = int.parse(input[1]);
    String turma = input[2];
    int pav = 1;
    int psm = 1;
    int pat = 1;
    int pse = 1;
    if(input.length>4){
      pav = int.parse(input[3]);
      psm = int.parse(input[4]);
      pat = int.parse(input[5]);
      pse = int.parse(input[6]);
    }
    return TurmaDAO(id: id, serie: serie, turma: turma, pAV: pav, pSM: psm, pAT: pat, pSE: pse);
  }

  bool equals(TurmaDAO t2){
    return serie==t2.serie && turma==t2.turma;
  }
}