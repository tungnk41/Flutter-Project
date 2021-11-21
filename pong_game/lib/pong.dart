import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ball.dart';
import 'bat.dart';

enum Direction { up, down, left, right}

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin{
  double screenWidth = 0;
  double screenHeight = 0;
  double posXBall = 0;
  double posYBall = 0;
  double ballDiameter = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPositionX = 0;
  double batPositionYBottom = 80;
  double increment = 2;
  int score = 0;
  double ranX = 1;
  double ranY = 1;

  late Animation<double> animation;
  late AnimationController controller;
  late Direction vDir;
  late Direction hDir;


  @override
  void initState() {
    posXBall = 0;
    posYBall = 0;
    vDir = Direction.down;
    hDir = Direction.right;
    controller = AnimationController(vsync: this, duration: const Duration(minutes: 100));
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetSatte((){
        posXBall = (hDir == Direction.right) ? posXBall+(increment*ranX).round() : posXBall-(increment*ranX).round();
        posYBall = (vDir == Direction.down) ? posYBall+(increment*ranY).round() : posYBall-(increment*ranY).round();
      });
      checkBallBorder();
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints contrains){
      screenWidth = contrains.maxWidth;
      screenHeight = contrains.maxHeight;
      batWidth = screenWidth/4;
      batHeight = screenHeight/25;
      ballDiameter = batWidth/4;
      return Stack(
        children: [
          Positioned(
            child: Ball(diameter: ballDiameter),
            top: posYBall,
            left: posXBall,),
          Positioned(
            left: batPositionX,
            bottom: batPositionYBottom,
            child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails update) => moveBat(update),
              child: Bat(width: batWidth,height: batHeight),),
          ),
          Positioned(
              top: 10,
              right: 30,
              child: Text("Score : $score"))
        ],
      );
    });
  }

  void checkBallBorder(){
    if(posXBall > (screenWidth - ballDiameter) && hDir == Direction.right){
      hDir = Direction.left;
      ranX = randomNumber();
    }
    else if(posXBall < 0 && hDir == Direction.left){
      hDir = Direction.right;
      ranX = randomNumber();
    }
    else if(posYBall < 0 && vDir == Direction.up){
      vDir = Direction.down;
      ranY = randomNumber();
    }
    else if(    (posYBall+ballDiameter >= (screenHeight - batPositionYBottom - batHeight) && posYBall+ballDiameter <= (screenHeight - batPositionYBottom - batHeight + 10))
        && ((posXBall+ballDiameter) >= batPositionX && posXBall <= batPositionX + batWidth)
        && (vDir == Direction.down)
    ){
        vDir = Direction.up;
        ranY = randomNumber();
        // safeSetSatte((){
        //   score++;
        // });
        score++;
    }
    else if(posYBall > (screenHeight - ballDiameter) && vDir == Direction.down){
        controller.stop();
        showMessage(context);
    }else{

    }
  }

  void moveBat(DragUpdateDetails update){
    safeSetSatte((){
      batPositionX = (batPositionX + update.delta.dx) < 0 ? 0 :
      ((batPositionX + update.delta.dx) > (screenWidth - batWidth) ? (screenWidth - batWidth) : (batPositionX + update.delta.dx));
    });
  }

  void safeSetSatte( Function function){
    if(mounted && controller.isAnimating){
      setState(() {
        function();
      });
    }
  }

  void showMessage(BuildContext context){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Game over"),
        content: Text("Would you like to play again"),
        actions: [
          TextButton(
              onPressed: (){
                setState(() {
                  posXBall = 0;
                  posYBall = 0;
                  score = 0;
                });
                Navigator.of(context).pop();
                controller.repeat();
              },
              child: Text("Yes")),
          TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                dispose();
              },
              child: Text("No"))
        ],
      );
    });
  }

  double randomNumber(){
    var ran = Random();
    int num = ran.nextInt(100); //random from 0 to 100
    return (num + 50)/100; //random from 0.5 to 1.5
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
