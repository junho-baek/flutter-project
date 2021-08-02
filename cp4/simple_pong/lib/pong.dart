import 'package:flutter/material.dart';
import 'ball.dart';
import 'bat.dart';
import 'dart:math';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  int score = 0;

  double randX = 1;
  double randY = 1;

  double randomNumber() {
    // 이 숫자는 0.5 에서 1.5 사이가 됩니다.
    var ran = new Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  double increment = 7;

  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  Animation<double>? animation;
  AnimationController? controller;

  @override
  void initState() {
    posX = 0;
    posY = 0;

    controller = AnimationController(
      duration: const Duration(minutes: 100000000),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 100).animate(controller!);
    animation?.addListener(() {
      safeSetState(() {
        if (hDir == Direction.right) {
          posX += (increment * randX).round();
        } else {
          posX -= (increment * randX).round();
        }
        if (vDir == Direction.down) {
          posY += (increment * randY).round();
        } else {
          posY -= (increment * randY).round();
        }
      });
      checkBorders();
    });

    controller?.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      width = constraints.maxWidth;
      height = constraints.maxHeight;
      batWidth = width / 5;
      batHeight = height / 30;

      return Stack(
        children: [
          Positioned(
            child: Text('Score:' + score.toString()),
            top: 0,
            right: 24,
          ),
          Positioned(
            child: Ball(),
            top: posY,
            left: posX,
          ),
          Positioned(
            bottom: 0,
            left: batPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails update) =>
                  moveBat(update),
              child: Bat(batWidth, batHeight),
            ),
          ),
        ],
      );
    });
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= (width - 25) && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - 25 - batHeight && vDir == Direction.down) {
      // 막대기가 여기 있는지 확인하고, 그렇지 않으면 진다.
      if (posX >= (batPosition - 25) && posX <= (batPosition + batWidth + 25)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
        });
      } else {
        controller?.stop();
        showMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void moveBat(DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void safeSetState(Function function) {
    if (mounted && controller!.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('한 판 더?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    setState(() {
                      posX = 0;
                      posY = 0;
                      score = 0;
                    });
                    Navigator.of(context).pop();
                    controller?.repeat();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('뒤로가기 누르세여'),
                      duration: Duration(seconds:1)));
                    Navigator.of(context).pop();
                    dispose();
                  },
                  child: Text('No')),

          
            ],
          );
        });
  }
}
