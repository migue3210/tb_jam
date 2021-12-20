import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool wasStarted = false;
  int _seconds = 0;
  int _minutes = 25;
  Timer? _timer;
  var f = NumberFormat("00");

  void _stopTimer() {
    _timer!.cancel();
    setState(() {
      _seconds = 0;
      _minutes = 25;
    });
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    if (_minutes > 0) {
      _seconds = _minutes * 60;
    }
    if (_seconds > 60) {
      _minutes = (_seconds / 60).floor();
      _seconds -= (_minutes * 60);
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _seconds = 59;
            _minutes--;
          } else {
            _timer!.cancel();
            // print("Timer Complete");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${f.format(_minutes)}:${f.format(_seconds)}",
            style:
                GoogleFonts.roboto(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          wasStarted == false
              ? ElevatedButton(
                  onPressed: () {
                    _startTimer();
                    setState(() {
                      wasStarted = true;
                    });
                  },
                  child: const Text('Start'),
                )
              : ElevatedButton(
                  onPressed: () {
                    _stopTimer();
                    setState(() {
                      wasStarted = false;
                    });
                  },
                  child: const Text('finish'),
                ),
        ],
      ),
    );
  }
}
