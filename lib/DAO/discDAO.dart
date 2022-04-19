class DiscDAO{
  final int id;
  final String nome;

  DiscDAO({
    required this.id,
    required this.nome,
  });

  factory DiscDAO.fromSheets(List<String> input) =>
      DiscDAO(id: int.parse(input[0]), nome: input[1]);
}