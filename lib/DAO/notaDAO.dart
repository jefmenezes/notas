class NotaDAO{
  final int id;
  final int idpagina;
  double? AV;
  double? SM;
  double? SE;
  double? AT;

  NotaDAO({
    required this.id,
    required this.idpagina,
    this.AV,
    this.SM,
    this.SE,
    this.AT
  });

  /*factory NotaDAO.fromSheets(List<String> input) =>
      NotaDAO(id: int.parse(input[0]), idpagina: int.parse(input[1]));*/

  factory NotaDAO.fromSheets(List<String> i){
    int id = int.parse(i[0]);
    int idp = int.parse(i[1]);
    double? av = double.tryParse(i[2]);
    double? sm = double.tryParse(i[3]);
    double? se = double.tryParse(i[4]);
    double? at = double.tryParse(i[5]);
    return NotaDAO(id: id, idpagina: idp, AV: av, SM: sm, SE: se, AT: at);
  }
}