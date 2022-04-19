class PaginaDAO{
  final int id;
  final int iddiario;
  final int idaluno;
  final int idn1;
  final int idn2;
  final int idn3;
  final int idn4;

  PaginaDAO({
    required this.id,
    required this.iddiario,
    required this.idaluno,
    required this.idn1,
    required this.idn2,
    required this.idn3,
    required this.idn4,
  });

  factory PaginaDAO.fromSheets(List<String> input) =>
      PaginaDAO(id: int.parse(input[0]), iddiario: int.parse(input[1]), idaluno: int.parse(input[2]), idn1: int.parse(input[3]), idn2: int.parse(input[4]), idn3: int.parse(input[5]), idn4: int.parse(input[6]));

}