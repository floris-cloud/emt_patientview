import 'dart:async';
import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

import '../models/patient.dart';

class TimerWidget extends StatefulWidget {
  final Patient patient;
  bool showFirstContact;
  TimerWidget({super.key, required this.patient, required this.showFirstContact});

  @override
  TimerWidgetState createState() => TimerWidgetState();
}

class TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late Duration _elapsed;
  late DateTime time;
  @override
  void initState() {
    super.initState();
      if(!widget.showFirstContact && widget.patient.protocls.last.contacts.isNotEmpty){
        time = widget.patient.protocls.last.contacts.keys.last;
    }else{
      time = widget.patient.protocls.last.createdAt;
    }
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
    Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {  
              widget.showFirstContact = !widget.showFirstContact;
                    if(!widget.showFirstContact && widget.patient.protocls.last.contacts.isNotEmpty){
                      time = widget.patient.protocls.last.contacts.keys.last;
                    }
                    else{
                      time = widget.patient.protocls.last.createdAt;
                    }
                              
            });
           
          },
          child: widget.showFirstContact ? Text(AppLocalizations.of(context)!.firstContact): Text(AppLocalizations.of(context)!.lastContact),
        ),
        Text(
         _formatDuration(_elapsed),
      style: TextStyle(fontSize: 24.0),
        ),
    
      ],
     
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}