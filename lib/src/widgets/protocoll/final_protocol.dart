import 'package:emt_patientview/src/widgets/patient_card_widget.dart';
import 'package:emt_patientview/src/widgets/protocoll/mds_selection_dialog.dart';
import 'package:flutter/material.dart';

import '../../models/patient.dart';
import 'medical_values_diagramm.dart';
import 'patient_info.dart';

class FinalProtocol extends StatelessWidget{
  final Patient patient;
  FinalProtocol({super.key, required this.patient});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        PatientInformation(patient: patient),
        // MedicalValuesDiagramm(patient: patient),
        Text('Anamnese: ${patient.protocls!.last.notes ?? ''}',),
        Text('Diagnose: ${patient.protocls!.last.mainDiagnose ?? ''}',),
         ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MdsSelectionDialog(patient: patient,);
                  },
                );
              },
              child: Text('MDS'),
            ),
         ElevatedButton(onPressed: (){
          patient.protocls!.last.sendProtocol();
         }, child: Text('Send Protocoll'),)
      ]
    );
  }
}