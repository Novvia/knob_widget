import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knob_widget/src/utils/knob_style.dart';
import 'package:provider/provider.dart';

class ControlKnob extends StatelessWidget {
  final double rotation;

  const ControlKnob(
    this.rotation, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = Provider.of<KnobStyle>(context);
    return Transform(
      transform: Matrix4.rotationZ(2 * pi * rotation),
      alignment: Alignment.center,
      child: Material(
        elevation: 0,
        shape: const CircleBorder(
          side: BorderSide(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        color: Colors.transparent,
        shadowColor: style.controlStyle.shadowColor,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: style.controlStyle.backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: style.controlStyle.glowColor,
                blurRadius: 0.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(0.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.asset(
                    'assets/dial.png',
                    fit: BoxFit.fill,
                    package: 'knob_widget',
                  ),
                  // child: CustomPaint(
                  //   painter: AllTickPainter(
                  //     tickCount: style.controlStyle.tickStyle.count,
                  //     margin: style.controlStyle.tickStyle.margin,
                  //     width: style.controlStyle.tickStyle.width,
                  //     color: style.controlStyle.tickStyle.color,
                  //   ),
                  // ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(style.pointerStyle.offset),
                  child: Container(
                    height: style.pointerStyle.height,
                    width: style.pointerStyle.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: style.pointerStyle.color,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
