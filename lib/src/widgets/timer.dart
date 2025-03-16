import 'dart:async';
import 'package:flutter/material.dart';

import '../models/patient.dart';

class TimerWidget extends StatefulWidget {
  final Patient patient;

  const TimerWidget({Key? key, required this.patient}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late Duration _elapsed;
  late DateTime time;
  @override
  void initState() {
    super.initState();
    time = widget.patient.firstContact;
    _elapsed = DateTime.now().difference(time);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = DateTime.now().difference(time);
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
    return 
    //TODO DropdownMenu für auswahl erst kontakt/ letzter Kontakt
    //DropdownMenu(dropdownMenuEntries: dropdownMenuEntries)
    Text(
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