import 'dart:math';
import 'package:flutter/material.dart';

class LancioDadi extends StatefulWidget {
  const LancioDadi({Key? key}) : super(key: key);

  @override
  State<LancioDadi> createState() => _LancioDadiState();
}

class _LancioDadiState extends State<LancioDadi> {
  //Variabili che salvano i valori numerici delle facce
  int _valPrimaFaccia = 1;
  int _valSecondaFaccia = 1;
  int _sommaDadi = 2;

  //Variabili che salvano il valore grafico dei singoli dadi
  late Image _primoDado = Image.asset('assets/Dado_1.png');
  late Image _secondoDado = Image.asset('assets/Dado_1.png');

  //Funzioni
  Image _lancioPrimoDado() {
    //Estrazione del valore compreso tra 1 - 6
    Random _randomVal;
    int min = 1;
    int max = 6;
    _randomVal = Random();

    //Generazione del valore random
    _valPrimaFaccia = min + _randomVal.nextInt(max - min);

    switch (_valPrimaFaccia) {
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

  //Funzione che lancia il secondo dado
  Image _lancioSecondoDado() {
    //Estrazione del valore compreso tra 1 - 6
    Random _randomVal;
    int min = 1;
    int max = 6;
    _randomVal = Random();

    //Generazione del valore random
    _valSecondaFaccia = min + _randomVal.nextInt(max - min);

    switch (_valSecondaFaccia) {
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
        content: Text('È uscito $_sommaDadi'),
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
              'Premi il bottone per lanciare i dadi',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: _primoDado,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: _secondoDado,
                ),
              ),
            ]),
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
                        _primoDado = _lancioPrimoDado();
                        _secondoDado = _lancioSecondoDado();
                        _sommaDadi = _valPrimaFaccia + _valSecondaFaccia;
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
        ));
  }
}
