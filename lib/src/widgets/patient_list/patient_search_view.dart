import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/patient.dart';
import '../../models/patient_list.dart';
class PopupPatientSearchView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: PatientSearchView(),
    );
  }
}


class PatientSearchView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PatientSearchViewState();
  }
}

class _PatientSearchViewState extends State<PatientSearchView>{
 
  @override
  Widget build(BuildContext context) {
    PatientListModel patientListModel = context.watch<PatientListModel>();
    return Column(
      children:[
        SearchAnchor(
        builder: (BuildContext context, SearchController controller) =>
         SearchBar(
          controller: controller,
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        ),
        suggestionsBuilder:  (BuildContext context, SearchController controller) {
              List<Patient> filterdPatients = patientListModel.getFilteredPatients(controller.text);
              return filterdPatients.map((Patient patient) => ListTile(
                title: Text('${patient.preName} ${patient.surName}'),
                subtitle: Text('${patient.id}'),
                onTap: () {
                  patient.active = true;
                  patientListModel.change(patient);
                },
              ),
              ).toList();
        }
        )
      ]

    );
  }
}

