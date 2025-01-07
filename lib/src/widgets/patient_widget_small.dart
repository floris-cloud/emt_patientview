

import 'package:flutter/widgets.dart';

import '../models/patient.dart';

class PatientWidgetSmall extends StatelessWidget {
 final Patient patient;
  const PatientWidgetSmall({super.key, required this.patient});
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Flexible(flex: 1,
            child: Text("00:00", style: TextStyle(backgroundColor: patient.triageCategory.getColor())),),
            Column(
             // mainAxisSize: MainAxisSize.min,
              children: [Text(patient.surName+", "+patient.preName),Text(patient.birthDate.toString())],)
    ]);
  }
}

class PatientWidgetSmallDragable extends StatelessWidget {
  final Patient patient;
  const PatientWidgetSmallDragable({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      child: 
        PatientWidgetSmall(patient: patient), 
      feedback: 
        PatientWidgetSmall(patient: patient),
      delay: Duration(milliseconds: 5),);
  }
}