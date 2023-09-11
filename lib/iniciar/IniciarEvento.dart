import 'package:flutter/material.dart';
import 'package:registropresencasurafo/detalhe/DetalheEvento.dart';
import 'package:registropresencasurafo/home/Home.dart';
import 'package:registropresencasurafo/infra/banco/DatabaseEvento.dart';

import '../entidade/Evento.dart';
import '../infra/color/AppColors.dart';

class IniciarEvento extends StatefulWidget {
  @override
  IniciarEventoState createState() => IniciarEventoState();
}

class IniciarEventoState extends State<IniciarEvento> {
  List<Evento> eventos = [];
  bool hasEventos = false;

  @override
  void initState() {
    super.initState();
    buscaEventos();
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
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalheEvento(evento),
                          ),
                        );
                      },
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
                                "${evento.descricao} - ${evento.dataInicio}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.corSecundaria,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.corSecundaria,
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
                'Nenhum evento cadastrado',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  buscaEventos() async {
    DatabaseEvento databaseHelper = DatabaseEvento.instance;
    eventos = await databaseHelper.getEventos();
    setState(() {
      hasEventos = eventos.isNotEmpty;
    });
  }
}
