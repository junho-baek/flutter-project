import 'package:flutter/material.dart';

class Ball extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double diam = 25;

    return Container(
      width: diam,
      height: diam,
      decoration: new BoxDecoration(
        color: Colors.amber[400],
        shape: BoxShape.circle,
      ),
      
    );
  }
}