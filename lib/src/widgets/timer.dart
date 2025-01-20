import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final DateTime startTime;

  const TimerWidget({Key? key, required this.startTime}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late Duration _elapsed;

  @override
  void initState() {
    super.initState();
    _elapsed = DateTime.now().difference(widget.startTime);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = DateTime.now().difference(widget.startTime);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(_elapsed),
      style: TextStyle(fontSize: 24.0),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}