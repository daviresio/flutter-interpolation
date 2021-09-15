import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:useful_utils/useful_utils.dart' as utils;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var top = 0.0;
  var left = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      setState(() {
        top = size.height / 2;
        left = size.width / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;

    final variationValue = utils.remap(top, 0, maxHeight, 0, 1);
    final lerpedColor = Color.lerp(Colors.red, Colors.green, variationValue);

    return Scaffold(
        body: GestureDetector(
      onPanUpdate: (dragUpdateDetails) {
        setState(() {
          top = dragUpdateDetails.globalPosition.dy;
          left = dragUpdateDetails.globalPosition.dx;
        });
      },
      child: Stack(
        children: [
          Container(
            color: lerpedColor,
          ),
          Positioned(
            top: top - 50,
            left: left - 50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
            ),
          ),
        ],
      ),
    ));
  }
}
