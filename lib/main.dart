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

  // --------Seconds, Minutes, Hours------------
  int seconds = 9;
  int mintutes = 5;
  int hour = 1;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    runTimer();
  }

  void runTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      // ----This is like constant variable, don't try to modify it.
      int backendValue = seconds + 1;
      setState(() {
        if (seconds <= 59 || seconds >= 0 || mintutes == 59) {
          if (seconds <= 59 && mintutes <= 59) {
            backendValue--;
            if (backendValue >= 1) {
              seconds--;
              // print('seconds');
              print(backendValue);
            } else if (backendValue == 0 && mintutes > 0) {
              seconds = 59;
              backendValue = 60;
              mintutes--;
              // print('minutes');
            } else if (mintutes == 0 && hour != 0) {
              hour--;
              mintutes = 59;
              seconds = 59;
              backendValue = 60;
              // print('hours');
            } else {
              timer.cancel();
              // print('Stopped');
            }
          }
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
                    SizedBox(width: mqSize.width * 0.007),

                    SizedBox(
                      height: mqSize.height * 0.1,
                      width: mqSize.width * 0.09,

                      child: Center(
                        child: FittedBox(
                          child: Text(
                            (hour == 0)
                                ? '${mintutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'
                                : '${hour.toString().padLeft(2, '0')}:${mintutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: timerSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
