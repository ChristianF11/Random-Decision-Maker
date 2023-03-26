import 'dart:math';
import 'package:flutter/material.dart';

class LancioMoneta extends StatefulWidget {
  const LancioMoneta({Key? key}) : super(key: key);

  @override
  State<LancioMoneta> createState() => _LancioMonetaState();
}

class _LancioMonetaState extends State<LancioMoneta> with TickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Offset> _fallingAnimation;
  bool _activeAnimation = false;
  bool _isHead = true;

  //Definizione del comportamento del controller
  @override
  void initState() {

    super.initState();

    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 0))
      ..forward();

    //Viene definito il tempo con cui si devono alternare le due facce
    _animation = TweenSequence([
      TweenSequenceItem(
        tween:
        Tween(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.linear)),
        weight: 0.375,
      ),
      TweenSequenceItem(
        tween:
        Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.linear)),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween:
        Tween(begin: 1.0, end: 1.5).chain(CurveTween(curve: Curves.linear)),
        weight: 0.375,
      ),
    ]).animate(_animationController);

    //Viene definito il movimento verso la zona inferiore dello schermo
    _fallingAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 1.0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    //Viene deciso l'esito del lancio in maniera randomica
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.forward ||
          _animationController.status == AnimationStatus.reverse) {
        if (_animationController.value < 1.5) {
          setState(() {
            _isHead = !_isHead;
          });
        } else {
          setState(() {
            _isHead = Random().nextBool();
          });
        }
      }
    });

    //Al termine dell'animazione si ripartirà con la faccia appena uscita
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isHead = _animation.value <= 0.5;
        });
      }
    });
  }

  @override
  void dispose() {

    _animationController.dispose();
    super.dispose();

  }

  //Funzione che serve per far alternare a livello grafico ed effettivo le due facce
  bool _coinToss() {
    setState(() {
      _isHead = Random().nextBool();
    });

    return _isHead;
  }

  //Struttura applicazione
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _activeAnimation
            ? null //Se l'animazione è in corso cliccando lo schermo non succederà nulla
            : () {
          setState(() {
            //La moneta è ferma e dunque vengono eseguite queste istruzioni
            _animationController.reset();
            _activeAnimation = true;

            _animationController.duration = //_activeAnimation
            //?
            const Duration(seconds: 1);
            //: const Duration(seconds: 0);
          });

          _animationController.forward().whenComplete(() {
            setState(() {
              _activeAnimation = false;
            });

            _animationController.stop();
          });
        },
        child: Container(
          child: Column(
              children: [
            const Text(
              'Clicca lo schermo per lanciare la monetina',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 250,
              child: SlideTransition(
                position: _fallingAnimation,
                child: Image.asset(
                  _coinToss()
                      ? 'assets/Moneta_testa.png'
                      : 'assets/Moneta_croce.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Un'app di Christian Fresu",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}
