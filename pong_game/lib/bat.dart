import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bat extends StatelessWidget{
  final double width;
  final double height;
  Bat({required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blue[600]
        ),
      );
  }


}