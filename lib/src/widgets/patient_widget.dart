
import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../screens/protocol_entry_screen.dart';

class PatientWidget extends StatefulWidget {
  final Patient patient;
  const PatientWidget({super.key, required this.patient});

  @override
  State<StatefulWidget> createState() => PatientWidgetState();
}

class PatientWidgetState extends State<PatientWidget> {
  late Color _backGroundColor;
  @override
 
  void initState() {
    super.initState();
    _backGroundColor = widget.patient.triageCategory.getColor();
    widget.patient.timer(() {
      if (mounted) {
        setState(() {
          _backGroundColor = Colors.red;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProtocolEntryScreen(patient: widget.patient),),);
      },
      child: Container(
        color: _backGroundColor,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(widget.patient.preName),
              ],
            ),
            const SizedBox(width: 5),
            Text(widget.patient.surName),
            const SizedBox(width: 20),
            const Icon(Icons.edit),
          ],
        ),
      ),
    );
  }
}

List<Widget> getPatientsWidgets(List<Patient> patients, BuildContext context) {
  List<Widget> patientsWidgets = [];
  for (Patient patient in patients) {
    patientsWidgets.add(PatientWidget(patient: patient));
  }
  return patientsWidgets;
}
