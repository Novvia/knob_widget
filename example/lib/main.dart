import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knob_widget/knob_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Knob Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Knob Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double _minimum = 15;
  final double _maximum = 49;

  late KnobController _controller;
  late int _knobValue;

  void valueChangedListener(double value) {
    if (mounted) {
      setState(() {
        _knobValue = value.floor();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _knobValue = _minimum.floor();
    _controller = KnobController(
      initial: _minimum,
      minimum: _minimum,
      maximum: _maximum,
      startAngle: -90,
      endAngle: 260,
      precision: 5,
    );
    _controller.addOnValueChangedListener(valueChangedListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_knobValue.toString()),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                var value = Random().nextDouble() * (_maximum - _minimum) + _minimum;
                _controller.setCurrentValue(value);
              },
              child: const Text('Update Knob Value'),
            ),
            const SizedBox(height: 75),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Knob(
                controller: _controller,
                width: 200,
                height: 200,
                style: KnobStyle(
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  showLabels: false,
                  tickOffset: 10,
                  labelOffset: 0,
                  minorTicksPerInterval: 20,
                  showMinorTickLabels: false,
                  minorTickStyle: MinorTickStyle(
                    color: Colors.black,
                  ),
                  controlStyle: ControlStyle(
                    backgroundColor: Colors.transparent,
                    glowColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  pointerStyle: const PointerStyle(
                    offset: 10.0,
                    height: 20,
                    width: 5,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.removeOnValueChangedListener(valueChangedListener);
    super.dispose();
  }
}
