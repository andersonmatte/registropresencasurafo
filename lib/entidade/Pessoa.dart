import 'package:registropresencasurafo/infra/banco/DatabasePessoa.dart';

class Pessoa {
  int? id;
  int? idEvento;
  String nome;
  String telefone;

  Pessoa(
      {this.id,
      required this.idEvento,
      required this.nome,
      required this.telefone});

  Map<String, dynamic> toMap() {
    return {
      DatabasePessoa.columnIdEvento: idEvento,
      DatabasePessoa.columnNome: nome,
      DatabasePessoa.columnTelefone: telefone,
    };
  }
}
