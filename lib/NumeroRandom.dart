import 'dart:math';
import 'package:flutter/material.dart';

class SceltaRandom extends StatefulWidget {
  const SceltaRandom({Key? key}) : super(key: key);

  @override
  State<SceltaRandom> createState() => _SceltaRandomState();
}

class _SceltaRandomState extends State<SceltaRandom> {
  //Variabili che memorizzano i valori numerici
  int _valoreMinimo = 0;
  int _valoreMassimo = 0;
  int _numeroCasuale = 0;

  //Variabili che gestiscono la visibilità di alcuni elementi
  bool _minimoValido = false;
  bool _massimoValido = false;
  bool _mostraNumero = false;

  //Controller per i 'TextField'
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  //Funzioni
  int _generaNumero() {
    Random _randomVal;
    int min = _valoreMinimo;
    int max = _valoreMassimo;
    _randomVal = Random();
    //Generazione del valore random
    return _numeroCasuale = min + _randomVal.nextInt(max - min);
  }

  void _showErrorAlert() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ERRORE'),
        content:
            const Text('Impossibile generare un numero con i valori inseriti'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Ok'),
            child: const Text('Fine'),
          )
        ],
      ),
    );
  }

  //Struttura
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Minimo',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          Container(
            //Input valore MINIMO
            margin: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _minController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Valore minimo',
                errorText: _minimoValido ? null : 'Inserire un numero',
              ),
              onChanged: (text) {
                setState(() {
                  int? valMinimo = int.tryParse(text);

                  if (valMinimo == null) {
                    setState(() => _minimoValido = false);
                    setState(() => _valoreMinimo = 0);
                  } else {
                    setState(() => _minimoValido = true);
                    setState(() => _valoreMinimo = valMinimo);
                  }
                });
              },
            ),
          ),
          const Text(
            'Massimo',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          Container(
            //Input valore MASSIMO
            margin: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _maxController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Valore massimo',
                errorText: _massimoValido ? null : 'Inserire un numero',
              ),
              onChanged: (text) {
                setState(() {
                  int? valMassimo = int.tryParse(text);

                  if (valMassimo == null) {
                    setState(() => _massimoValido = false);
                    setState(() => _valoreMassimo = 0);
                  } else {
                    setState(() => _massimoValido = true);
                    setState(() => _valoreMassimo = valMassimo);
                  }
                });
              },
            ),
          ),
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
                    if (_valoreMassimo < _valoreMinimo ||
                        _valoreMassimo == _valoreMinimo) {
                      _showErrorAlert();
                    } else {
                      setState(() {
                        _numeroCasuale = _generaNumero();
                        _mostraNumero = true;
                      });
                    }
                  },
                  child: const Text('Genera'),
                ),
              ),
            ),
          ),
          const Text(
            'Numero casuale:',
            style: TextStyle(
              fontSize: 20.0,
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Visibility(
              visible: _mostraNumero,
              child: Text(
                '$_numeroCasuale',
                style: const TextStyle(fontSize: 28.0),
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
