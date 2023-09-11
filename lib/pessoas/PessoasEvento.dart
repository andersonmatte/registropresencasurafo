import 'package:flutter/material.dart';
import 'package:registropresencasurafo/detalhe/DetalheEvento.dart';
import 'package:registropresencasurafo/home/Home.dart';
import 'package:registropresencasurafo/infra/banco/DatabaseEvento.dart';
import 'package:registropresencasurafo/infra/banco/DatabasePessoa.dart';

import '../entidade/Evento.dart';
import '../entidade/Pessoa.dart';
import '../infra/color/AppColors.dart';

class PessoasEvento extends StatefulWidget {
  final Evento evento;

  PessoasEvento(this.evento);
  
  @override
  PessoasEventoState createState() => PessoasEventoState();
}

class PessoasEventoState extends State<PessoasEvento> {
  List<Pessoa> pessoas = [];
  bool hasEventos = false;

  @override
  void initState() {
    super.initState();
    buscaPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Iniciar um Evento',
          style: TextStyle(
            color: AppColors.corPrincipal,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.corPrincipal),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: hasEventos
          ? ListView.builder(
        itemCount: pessoas.length,
        itemBuilder: (context, index) {
          final pessoa = pessoas[index];
          return Column(
            children: [
              GestureDetector(
                child: Container(
                  height: 70.0,
                  color: const Color(0xFFF1EEE7),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pessoa.nome,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.corSecundaria,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: AppColors.corSecundaria,
                height: 1.0,
                thickness: 1.0,
              ),
            ],
          );
        },
      )
          : const Center(
        child: Text(
          'Nenhuma pessoa registrada',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  buscaPessoas() async {
    DatabasePessoa databaseHelper = DatabasePessoa.instance;
    pessoas = await databaseHelper.getPessoasPorIdEvento(widget.evento.id!);
    setState(() {
      hasEventos = pessoas.isNotEmpty;
    });
  }
}
