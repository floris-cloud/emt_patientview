import 'package:emt_patientview/src/models/patient_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../patient_card_draggable.dart';


class PatientListView extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
var patientListModel = context.watch<PatientListModel>();

    return ListView.builder(
      itemCount: patientListModel.patients.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: PatientCardDraggable(patient: patientListModel.patients[index]),
        );
      },
    );
}
}