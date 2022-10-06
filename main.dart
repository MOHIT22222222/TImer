// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: NewStopWatch()));
  }
}

class NewStopWatch extends StatefulWidget {
  @override
  _NewStopWatchState createState() => _NewStopWatchState();
}

class _NewStopWatchState extends State<NewStopWatch> {
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;

  int click = 0;

  String elapsedTime = '';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(elapsedTime, style: TextStyle(fontSize: 25.0)),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: "btn1",
                  backgroundColor: Colors.red,
                  onPressed: () {
                    click++;
                    if (click >= 4) {
                      print("A $click");

                      restart();
                    } else {
                      print("B $click");
                      startOrStop();
                    }
                  },
                  child: Icon(Icons.pause)),
              SizedBox(width: 20.0),
              FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Colors.green,
                  onPressed: () {
                    click = 0;
                    print(click);
                  }, //resetWatch,
                  child: Icon(Icons.check)),
            ],
          )
        ],
      ),
    );
  }

  restart() {
    watch.reset();
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    setState(() {
      startStop = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    // String hoursStr = (hours % 60).toString().padLeft(2, '0');
    // String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "${secondsStr} Sec";
  }
}
