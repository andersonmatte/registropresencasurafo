import 'package:flutter/material.dart';
import 'package:registropresencasurafo/consultar/ConsultarPresenca.dart';
import 'package:registropresencasurafo/iniciar/IniciarEvento.dart';
import 'package:registropresencasurafo/registrar/RegistrarEvento.dart';
import 'package:registropresencasurafo/splash/SplashScreen.dart';

import '../exportar/ExportarDados.dart';
import '../infra/color/AppColors.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomePage> {
  final List<Map<String, dynamic>> items = [
    {'logo': 'assets/images/registered.png', 'name': 'Registrar Evento'},
    {'logo': 'assets/images/right.png', 'name': 'Iniciar Evento'},
    {'logo': 'assets/images/search.png', 'name': 'Consultar Presenças'},
    {'logo': 'assets/images/export.png', 'name': 'Exportar Dados'},
  ];

  void cliqueCardView(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RegistroEvento()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => IniciarEvento()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ConsultarPresenca()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ExportarDados()),
        );
        break;
      default:
        break;
    }
  }

  final cpfController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(left: 48.0, right: 48.0),
          child: Text(
            'Registro de Presença SURAFO',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: List.generate(items.length, (index) {
                    return SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: GestureDetector(
                        onTap: () {
                          cliqueCardView(index);
                        },
                        child: Card(
                          color: Color(0xFFe8e8e6),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    items[index]['logo'],
                                    width: 64.0,
                                    height: 64.0,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    items[index]['name'],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
