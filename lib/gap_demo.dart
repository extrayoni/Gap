import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:core';

import 'package:flutter/material.dart';
import 'counter_storage.dart';
import 'water.dart';

class GapDemo extends StatefulWidget {
  const GapDemo({super.key, required this.storage, required this.debugMode});

  final CounterStorage storage;
  final bool debugMode;

  @override
  State<GapDemo> createState() => _GapDemoState();
}

class _GapDemoState extends State<GapDemo> {
  int _counter = 0;
  static const MAX_COUNTER =  1.0 / (0.036 / 2.0);
  Water water = Water(1);


  bool setWater(factor){
    water.HEIGHT_FACTOR = 1.0 - (factor * 0.036 / 2);
    return true;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
        setWater(_counter);
      });
    });
  }

  Future<File> _resetCounter() {
    setState(() {
      _counter=0;
      setWater(_counter);
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter >= MAX_COUNTER)
        _counter = 0;
      setWater(_counter);
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  Future<File> _decrementCounter() {
    setState(() {
      _counter--;
      setWater(_counter);
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Scaffold(
          backgroundColor: const Color(0xFFD8DCF5),
          body: Stack(children: [
            CustomPaint(
              willChange: true,
              painter: water,
              child: Container(),
            ),
            Center(
              child: buildTapButton(context),
              // Text(
              //   'You drank $_counter time${_counter == 1 ? '' : 's'}.',
              //   textAlign: TextAlign.center,
              //   textScaleFactor: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(fontWeight: FontWeight.bold),
              // )
          ),]),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: buildDebugButtons(context),
        ));
  }

  Widget buildTapButton(BuildContext context){
      return OutlinedButton(
        onPressed: _incrementCounter,
        style: ButtonStyle(
          foregroundColor: const MaterialStatePropertyAll(Colors.black),
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          side: MaterialStateProperty.resolveWith<BorderSide?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const BorderSide(color: Color(0xFF3654FF), width: 20);
              }
              return const BorderSide(color: Color(0xFF3654FF), width: 5);
            },
          ),
          fixedSize: MaterialStatePropertyAll(Size(240 ,220)),
          shape: MaterialStatePropertyAll(CircleBorder()),
          padding: MaterialStatePropertyAll(EdgeInsets.all(50)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("Tap to add", textScaleFactor: 1.5,),
              ),
            ),
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Text("50ml", textScaleFactor: 3, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      );
  }

  Widget buildDebugButtons(BuildContext context){
    if (widget.debugMode) {
      return Stack(
        fit: StackFit.expand,
        children: [
          // Positioned.fill(
          //     child: Align(
          //         alignment: Alignment.center,
          //         child: buildTapButton(context),
          // )),
          Positioned(
            left: 50,
            bottom: 20,
            child: FloatingActionButton(
              heroTag: 'down',
              onPressed: _decrementCounter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                size: 40,
                Icons.no_drinks,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 50,
            child: FloatingActionButton(
              heroTag: 'up',
              onPressed: _incrementCounter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.water_drop,
                size: 40,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 150,
            right: 150,
            child: FloatingActionButton(
              heroTag: 'reset',
              onPressed: _resetCounter,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.exposure_zero_sharp,
                size: 40,
              ),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      );
    }
    return Stack();
  }

}

