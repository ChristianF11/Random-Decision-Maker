import 'dart:math';
import 'package:flutter/material.dart';

class LancioDado extends StatefulWidget {
  const LancioDado({Key? key}) : super(key: key);

  @override
  State<LancioDado> createState() => _LancioDadoState();
}

class _LancioDadoState extends State<LancioDado> {
  //Variabile che salva il valore numerico del dado
  int _valoreFaccia = 1;

  //Variabile che salva il valore grafico del dado
  late Image _facciaDado = Image.asset('assets/Dado_1.png');

  //Funzioni
  Image _lancio() {
    //Estrazione del valore compreso tra 1 - 6
    Random _randomVal;
    int min = 1;
    int max = 6;
    _randomVal = Random();

    //Generazione del valore random
    _valoreFaccia = min + _randomVal.nextInt(max - min);

    //Restituzione della faccia corretta
    switch (_valoreFaccia) {
      case 1:
        return Image.asset('assets/Dado_1.png');

      case 2:
        return Image.asset('assets/Dado_2.png');

      case 3:
        return Image.asset('assets/Dado_3.png');

      case 4:
        return Image.asset('assets/Dado_4.png');

      case 5:
        return Image.asset('assets/Dado_5.png');

      case 6:
        return Image.asset('assets/Dado_6.png');

      default:
        return Image.asset('assets/Errore.png');
    }
  }

  //Esito
  void _showSnackBar() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('È uscito $_valoreFaccia'),
        duration: const Duration(milliseconds: 1500),
      ));

  //Struttura
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Premi il bottone per lanciare il dado',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          _facciaDado,
          SizedBox(
            height: 100,
            width: 85,
            child: ButtonTheme(
              minWidth: 85,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff448aff),
                  ),
                  onPressed: () {
                    setState(() {
                      _facciaDado = _lancio();
                    });
                    _showSnackBar();
                  },
                  child: const Text('Lancio'),
                ),
              ),
            ),
          ),
          const Text("Un'app di Christian Fresu",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
