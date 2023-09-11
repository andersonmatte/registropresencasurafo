import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registropresencasurafo/home/Home.dart';
import 'package:registropresencasurafo/infra/banco/DatabaseEvento.dart';

import '../entidade/Evento.dart';
import '../infra/color/AppColors.dart';

class RegistroEvento extends StatefulWidget {
  @override
  RegistroEventoState createState() => RegistroEventoState();
}

class RegistroEventoState extends State<RegistroEvento> {
  final TextEditingController dataInicioController = TextEditingController();
  final TextEditingController dataFimController = TextEditingController();
  late DateTime dataSelecionada1 = DateTime.now();
  late DateTime dataSelecionada2 = DateTime.now();

  String eventoSelecionado = "Selecione um Evento";

  final List<String> eventos = [
    'Selecione um Evento',
    'Batuque Oxum Pandá',
    'Batuque Bará Lodê',
    'Festa Umbanda',
    'Festa Exú',
    'Homenagem Umbanda',
    'Homenagem Exú',
    'Dr Josué',
    'Sessão Caboclo',
    'Sessão Cosme',
    'Sessão Exú',
    'Sessão Preto Velho',
    'Sessão Tronqueira',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          'Registrar Novo Evento',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14.0),
                    const Text(
                      'Nome Evento',
                      style: TextStyle(
                        color: AppColors.corPrincipal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      height: 48, // Defina a altura desejada
                      child: DropdownButtonFormField(
                        icon: const Icon(Icons.arrow_drop_down,
                            color: AppColors.corPrincipal),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.corPrincipal),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColors.corPrincipal),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                        ),
                        isExpanded: false,
                        value: eventoSelecionado,
                        onChanged: (value) {
                          setState(() {
                            eventoSelecionado = value!;
                          });
                        },
                        items: eventos.map((estado) {
                          return DropdownMenuItem(
                            value: estado,
                            child: Text(
                              estado,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    const Text(
                      'Data Inicial',
                      style: TextStyle(
                        color: AppColors.corPrincipal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: dataInicioController,
                      decoration: InputDecoration(
                        hintText: 'dd/mm/aaaa hh:mm',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            onChangeData(context, 1);
                          },
                          child: const Icon(Icons.calendar_month,
                              color: AppColors.corSecundaria),
                        ),
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
                    const SizedBox(height: 14.0),
                    const Text(
                      'Data Final',
                      style: TextStyle(
                        color: AppColors.corPrincipal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: dataFimController,
                      decoration: InputDecoration(
                        hintText: 'dd/mm/aaaa hh:mm',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            onChangeData(context, 2);
                          },
                          child: const Icon(Icons.calendar_month,
                              color: AppColors.corSecundaria),
                        ),
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
                    const SizedBox(height: 14.0),
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
                              DatabaseEvento databaseHelper = DatabaseEvento.instance;
                              // Inserir um registro
                              Evento novoRegistro = Evento(
                                dataInicio: dataInicioController.text,
                                dataFim: dataFimController.text,
                                descricao: eventoSelecionado,
                              );
                              int registroId = await databaseHelper.insereEvento(novoRegistro);
                              print('Registro inserido com o ID: $registroId');
                              showToast(context, "Evento Salvo com Sucesso!");
                            },
                            child: Text(
                              "Salvar evento".toUpperCase(),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onChangeData(BuildContext context, int numeroData) async {
    DateTime? pickedDate;
    TimeOfDay? pickedTime;
    pickedDate = await showDatePicker(
      context: context,
      initialDate: numeroData == 1 ? dataSelecionada1 : dataSelecionada2,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.corPrincipal, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black54, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.corPrincipal, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      // Selecionar a hora
      pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.corPrincipal, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.black54, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.corPrincipal, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
    }
    if (numeroData == 1) {
      if (pickedDate != null && pickedTime != null) {
        setState(() {
          dataSelecionada1 = DateTime(
            pickedDate!.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime!.hour,
            pickedTime.minute,
          );
          dataInicioController.text =
              DateFormat('dd/MM/yyyy HH:mm').format(dataSelecionada1);
        });
      }
    } else {
      if (pickedDate != null && pickedTime != null) {
        setState(() {
          dataSelecionada2 = DateTime(
            pickedDate!.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime!.hour,
            pickedTime.minute,
          );
          dataFimController.text =
              DateFormat('dd/MM/yyyy HH:mm').format(dataSelecionada2);
        });
      }
    }
  }
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
