import 'dart:math';
import 'package:flutter/material.dart';

class LancioMoneta extends StatefulWidget {
  const LancioMoneta({Key? key}) : super(key: key);

  @override
  State<LancioMoneta> createState() => _LancioMonetaState();
}

class _LancioMonetaState extends State<LancioMoneta> with SingleTickerProviderStateMixin{

  //Controller con il compito di gestire l'animazione della moneta
  late AnimationController _controller;
  bool _risultato = true;
  String _faccia = '';

  //Definizione del comportamento del controller
  @override
  void initState() {

    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();

  }

  //Funzioni
  bool _lancio() {
    bool _esito = Random().nextBool();
    setState(() =>
        _risultato = _esito); //Viene aggiornato lo 'State' di '_risultato'

    if (_esito) {
      _faccia = "testa";
    } else {
      _faccia = "croce";
    }

    return _esito;
  }

  void _showSnackBar() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('È uscita $_faccia'),
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
            'Premi il bottone per lanciare la monetina',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          Visibility(
            visible: _risultato,
            child: SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/Moneta_testa.png'),
            ),
          ),
          Visibility(
            visible: !_risultato,
            child: SizedBox(
              height: 265,
              width: 250,
              child: Image.asset('assets/Moneta_croce.png'),
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
                    _lancio();
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
