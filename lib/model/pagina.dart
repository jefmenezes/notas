import 'package:notas/model/aluno.dart';
import 'package:notas/model/diario.dart';
import 'package:notas/model/nota.dart';

class Pagina{
  final Diario diario;
  final Aluno aluno;
  final Nota n1;
  final Nota n2;
  final Nota n3;
  final Nota n4;

  Pagina(this.diario, this.aluno, this.n1, this.n2, this.n3, this.n4);
}