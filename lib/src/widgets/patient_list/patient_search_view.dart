import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/patient.dart';
import '../../models/patient_list.dart';
import '../treatment_station_widget/pop_up_patient_list.dart';
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
              List<Patient> filterdPatients = context.read<PatientListModel>().getFilteredPatients(controller.text);
              return filterdPatients.map((Patient patient) => ListTile(
                title: Text('${patient.preName} ${patient.surName}'),
                subtitle: Text('${patient.id}'),
                onTap: () {
                  setState(() {                  
                  patient.active = true;
                  context.read<PatientListModel>().change(patient);
                  controller.closeView(patient.id);
                  });           
                },
              ),
              ).toList();
        }
        )
      ]

    );
  }
}

