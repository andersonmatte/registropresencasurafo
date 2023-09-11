import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:registropresencasurafo/infra/banco/DatabaseEvento.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../entidade/Evento.dart';
import '../entidade/Pessoa.dart';
import '../home/Home.dart';
import '../infra/banco/DatabasePessoa.dart';
import '../infra/color/AppColors.dart';

class ExportarDados extends StatefulWidget {
  @override
  ExportarDadosState createState() => ExportarDadosState();
}

class ExportarDadosState extends State<ExportarDados> {
  List<Evento> eventos = [];
  bool hasEventos = false;
  late Future googleFontsPending;

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
          'Exportar Dados',
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
                      onTap: () async {
                        DatabasePessoa databaseHelper = DatabasePessoa.instance;
                        List<Pessoa> pessoas = await databaseHelper
                            .getPessoasPorIdEvento(evento.id!);
                        gerarDocumento(pessoas,
                            "${evento.descricao}-${evento.dataInicio}");
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
                                Icons.file_copy_outlined,
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

  Future<void> gerarDocumento(List<Pessoa> pessoas, String nomeArquivo) async {
    String conteudo = "$nomeArquivo\n";

    //Create a new PDF document
    PdfDocument document = PdfDocument();

    for (var i = 0; i < pessoas.length; i++) {
      final item = pessoas[i];
      conteudo += "${item.nome} ${item.telefone}\n";
    }

    //Add a new page and draw text
    document.pages.add().graphics.drawString(
        conteudo, PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: Rect.fromLTWH(0, 0, 500, 50));

    //Save the document
    List<int> bytes = await document.save();

    //Dispose the document
    document.dispose();

    const directory = '/storage/sdcard0/Download/';
    //final path = directory.path;
    final file = new File('$directory$nomeArquivo.pdf').create(recursive: true);
    OpenFile.open('$directory$nomeArquivo.pdf');
    // if (!await directory.exists()) {
    //   await directory.create(recursive: true);
    // }

//Write PDF data
    //await file.writeAsBytes(bytes, flush: true);

//Open the PDF document in mobile
    //OpenFile.open('$path/$nomeArquivo.pdf');

    // final xcel.Workbook workbook = xcel.Workbook();
    // final xcel.Worksheet sheet = workbook.worksheets[0];
    //
    // sheet.getRangeByIndex(1, 1).setText("Nome");
    // sheet.getRangeByIndex(1, 2).setText("Telefone");
    //
    // for (var i = 0; i < pessoas.length; i++) {
    //   final item = pessoas[i];
    //   sheet.getRangeByIndex(i + 2, 1).setText(item.nome);
    //   sheet.getRangeByIndex(i + 2, 2).setText(item.telefone);
    // }
    //
    // final List<int> bytes = workbook.saveAsStream();
    // workbook.dispose();
    //
    // final directory = Directory('/storage/sdcard0/Download/');
    // await directory.create(recursive: true);
    // final file = File('${directory.path}$nomeArquivo');
    // await file.writeAsBytes(bytes);
  }
}
