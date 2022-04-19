class DiarioDAO{
  final int id;
  final int idturma;
  final int idprof;
  final int iddisc;

  DiarioDAO({
    required this.id,
    required this.idturma,
    required this.idprof,
    required this.iddisc
  });

  factory DiarioDAO.fromSheets(List<String> input) =>
      DiarioDAO(id: int.parse(input[0]), idturma: int.parse(input[1]), idprof: int.parse(input[2]), iddisc: int.parse(input[3]));
}