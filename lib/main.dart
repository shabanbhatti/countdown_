import 'dart:async';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyApppState();
}

class _MyApppState extends State<MyApp> {
  //----------widgets variables----------

  double containerHeight = 60;
  double containerWidth = 150;
  BorderRadiusGeometry? containerRadius = BorderRadius.circular(10);
  Color containerColor = const Color.fromARGB(255, 60, 58, 58);
  double clockIconSize = 30;
  Color textIconColor = Colors.white;
  double timerSize = 20;

  // --------timer variables------------
  int seconds = 59;
  int mintutes = 59;
  int hour = 12;

  int backendValue = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    runTimer();
  }

  void runTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds <= 59 || seconds >= 0 || mintutes == 59) {
          backendValue--;
          if (backendValue >= 1) {
            seconds--;
          } else if (backendValue == 0 && mintutes > 0) {
            seconds = 59;
            backendValue = 60;
            mintutes--;
          } else if (mintutes == 0) {
            hour--;
            mintutes = 59;
            seconds = 59;
            backendValue = 60;
          }
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mqSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: containerHeight,
                width: containerWidth,

                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: containerRadius,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_filled,

                      color: Colors.white,
                      size: clockIconSize,
                    ),
                    SizedBox(width: mqSize.width * 0.01),

                    Text(
                      (hour == 0)
                          ? '${mintutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
                          : '${hour.toString().padLeft(2, '0')}:${mintutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: timerSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
