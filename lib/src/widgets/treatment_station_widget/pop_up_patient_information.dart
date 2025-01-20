import 'package:emt_patientview/src/widgets/patient_input/patient_input_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/patient.dart';
import '../../models/patient_list.dart';
import '../../models/person.dart';
import '../../models/triage_category.dart';
import '../patient_input/patient_input_controller.dart';

class PopUpPatientInformation extends StatefulWidget {
  final Patient patient;
  final Function(Patient) onPatientUpdated;

  const PopUpPatientInformation({Key? key, required this.patient, required this.onPatientUpdated}) : super(key: key);

  @override
  _PopUpPatientInformationState createState() => _PopUpPatientInformationState();
}

class _PopUpPatientInformationState extends State<PopUpPatientInformation> {



  @override
  Widget build(BuildContext context) {
    PatientInputController patientInputController = PatientInputController();
    return AlertDialog(
      content:  ChangeNotifierProvider(
          create: (context) => patientInputController,
          child:PatientInputView(),
    ),
    actions: [
        TextButton(
          child: Text('Abbrechen'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Speichern'),
          onPressed: () {
            
            widget.onPatientUpdated(patientInputController.createPatient());
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    }
  }