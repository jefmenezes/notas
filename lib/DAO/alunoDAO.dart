class AlunoDAO{
  final int id;
  final int idturma;
  final String nome;
  final int status;
  final int idtutor;

  AlunoDAO({
    required this.id,
    required this.idturma,
    required this.nome,
    required this.status,
    this.idtutor = 0,
  });

  factory AlunoDAO.fromSheets(List<String> input) =>
      AlunoDAO(id: int.parse(input[0]), idturma: int.parse(input[1]), nome: input[2], status: int.parse(input[3]), idtutor: int.parse(input[3]));
}