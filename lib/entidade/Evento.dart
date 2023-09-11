import 'package:registropresencasurafo/infra/banco/DatabaseEvento.dart';

class Evento {
  int? id;
  String dataInicio;
  String dataFim;
  String descricao;

  Evento({this.id, required this.dataInicio, required this.dataFim, required this.descricao});

  Map<String, dynamic> toMap() {
    return {
      DatabaseEvento.columnDataInicio: dataInicio,
      DatabaseEvento.columnDataFim: dataFim,
      DatabaseEvento.columnDescricao: descricao,
    };
  }
}