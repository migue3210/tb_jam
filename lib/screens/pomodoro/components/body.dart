import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tb_jam/configurations/constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool wasStarted = false;

  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircularCountDownTimer(
            duration: 1500,
            initialDuration: 0,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
            ringColor: Colors.grey[300] as Color,
            // fillColor: kPrimaryColor,
            // backgroundColor: Colors.white,
            fillColor: Colors.purpleAccent[100] as Color,
            backgroundColor: Colors.purple[500],
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: const TextStyle(
                fontSize: 33.0,
                // color: Colors.black,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.MM_SS,
            isReverse: true,
            isTimerTextShown: true,
            autoStart: false,
          ),
          wasStarted == false
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {
                    // _startTimer();
                    _controller.start();

                    setState(() {
                      wasStarted = true;
                    });
                  },
                  child: Text(
                    'Empezar',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {
                    // _stopTimer();
                    _controller.restart();
                    _controller.pause();
                    setState(() {
                      wasStarted = false;
                    });
                  },
                  child: Text(
                    'Finalizar',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
