import 'package:flutter/material.dart';
import './Moneta.dart';
import './Dado.dart';
import './Dadi.dart';
import './NumeroRandom.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //Nuove Feature da inserire:
  //Implementare animazione della moneta che gira (prima di restituire l'esito)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generatore di scelte random'),
          backgroundColor: Colors.blueAccent,
          bottom: TabBar(tabs: [
            Tab(
              //icon: Icon(Icons.circle_outlined),
              icon: SizedBox(
                //Dimensioni massime per mettere l'immagine come 'icon'
                height: 43,
                width: 43,
                child: Image.asset('assets/Moneta_testa.png'),
              ),
              text: "Moneta",
            ),
            Tab(
              icon: SizedBox(
                //Dimensioni massime per mettere l'immagine come 'icon'
                height: 43,
                width: 43,
                child: Image.asset('assets/Dado_1.png'),
              ),
              text: "1 Dado",
            ),
            Tab(
              icon: SizedBox(
                //Dimensioni massime per mettere l'immagine come 'icon'
                height: 43,
                width: 43,
                child: Image.asset('assets/2_Dadi.png'),
              ),
              text: "2 Dadi",
            ),
            Tab(
              icon: SizedBox(
                //Dimensioni massime per mettere l'immagine come 'icon'
                height: 43,
                width: 43,
                child: Image.asset('assets/Numeri_random.png'),
              ),
              text: "Numero",
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            LancioMoneta(),
            LancioDado(),
            LancioDadi(),
            SceltaRandom(),
          ],
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
