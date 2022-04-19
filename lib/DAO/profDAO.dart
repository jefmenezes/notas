class ProfDAO{
  final int id;
  final String nome;
  final String email;

  ProfDAO({
    required this.id,
    required this.nome,
    required this.email
  });

  factory ProfDAO.fromSheets(List<String> input) =>
      ProfDAO(id: int.parse(input[0]), nome: input[1], email: input[2]);
}