import 'package:flutter/material.dart';
import 'package:registropresencasurafo/entidade/Evento.dart';
import 'package:registropresencasurafo/infra/banco/DatabasePessoa.dart';
import 'package:registropresencasurafo/infra/color/AppColors.dart';
import 'package:registropresencasurafo/iniciar/IniciarEvento.dart';

import '../entidade/Pessoa.dart';

class DetalheEvento extends StatefulWidget {
  final Evento evento;

  DetalheEvento(this.evento);

  @override
  DetalheEventoState createState() => DetalheEventoState();
}

class DetalheEventoState extends State<DetalheEvento> {
  DatabasePessoa databaseHelper = DatabasePessoa.instance;
  List<Pessoa> pessoas = [];
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buscaPessoasPresentes(widget.evento.id);
    print("Está buscando");
  }

  @override
  Widget build(BuildContext context) {
    String titulo = widget.evento.descricao;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Lista de Presença',
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
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => IniciarEvento()));
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.corSecundaria),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Nome',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.corPrincipal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: nomeController,
                  decoration: InputDecoration(
                    hintText: 'Informe o seu nome',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.corPrincipal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.corPrincipal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Telefone',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.corPrincipal),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: telefoneController,
                  decoration: InputDecoration(
                    hintText: 'Informe o seu telefone',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.corPrincipal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.corPrincipal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 40,
                      width: 250,
                      margin: const EdgeInsets.only(top: 30.0),
                      decoration: BoxDecoration(
                        color: AppColors.corPrincipal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (nomeController.text.isEmpty || telefoneController.text.isEmpty){
                            showToast(context, "Preencha os campos nome e telefone!");
                          } else {
                            // Inserir um registro
                            Pessoa novoRegistro = Pessoa(
                              idEvento: widget.evento.id,
                              nome: nomeController.text,
                              telefone: telefoneController.text,
                            );
                            int registroId =
                            await databaseHelper.inserePessoa(novoRegistro);
                            print('Registro inserido com o ID: $registroId');
                            showToast(context, "Presença registrada!");
                            int? idEvento = widget.evento.id;
                            await buscaPessoasPresentes(idEvento);
                            limpaCampos();
                          }
                        },
                        child: Text(
                          "Registrar Presença".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          const Center(
            child: Text(
              "Lista de Presentes",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.corSecundaria,
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Expanded(
              child: ListView.builder(
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
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pessoa.nome,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 14.0,
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
          )),
        ],
      ),
    );
  }

  Future<void> buscaPessoasPresentes(int? idEvento) async {
    pessoas = await databaseHelper.getPessoasPorIdEvento(idEvento!);
    setState(() {
      pessoas;
    });
  }

  limpaCampos(){
    nomeController.clear();
    telefoneController.clear();
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: AppColors.corPrincipal
            .withOpacity(0.7), // Define a cor de fundo com 50% de transparência
      ),
    );
  }
}
