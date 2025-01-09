import 'package:emt_patientview/src/widgets/patient_card_draggable.dart';
import 'package:emt_patientview/src/widgets/treatment_station_widget/treatment_station_widget_drop.dart';
import 'package:emt_patientview/src/widgets/treatment_station_widget/treatment_station_widget_view.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../models/person.dart';
import '../models/treatment_station.dart';
import '../models/triage_category.dart';
import '../repository/patient_repository.dart';
//import '../widgets/patient_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/add_patient_button.dart';
import '../widgets/patient_card_widget.dart';
import '../widgets/app_bar.dart';

class AllPatDeskScreen extends StatefulWidget {
  const AllPatDeskScreen({super.key});

  @override
  State<AllPatDeskScreen> createState() =>_AllPatDeskcreenState();
}

class _AllPatDeskcreenState extends State<AllPatDeskScreen> {
  TextEditingController editingController = TextEditingController();
  List<Patient> allPatients = [];
  List<Patient> filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  void _loadPatients() async {
    final patients = await PatientStorage.loadPatients();
    setState(() {
      filteredPatients = patients;
    });
  }
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.allPatients),
      body:   
      Row(
        
        children: [

        Flexible(flex: 1, 
        child: 
        Column(children: [
          Flexible(flex:1, child:Container(color: Colors.red,)), 
          Text(AppLocalizations.of(context)!.waitingArea, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          
          PatientCardDraggable
            (patient: Patient(surName: "Müller", preName: "preName", gender: Gender.male, triageCategory: TriageCategory(2)),),
         Expanded(
                  child: ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (context, index) {
                      return PatientCard(patient: filteredPatients[index]);
                    },
                  ),
                ),
          AddPatientButton(),
        
          Flexible(flex:3, child:Container(color: Colors.red,)), 
        ]
        )), 
        
        Expanded(flex: 2, child: Container( color: Colors.blue,
         child:  
         Column(
          children: [
          Wrap(
            children: [
              TreatmentStationWidgetDrop(treatmentStation: TreatmentStation(id: 1, name: "Station 1", color: Colors.red)),
          ],
        ),
        ]
        ),
        ),),
      
            Flexible(flex: 1, child: Container( color: Colors.red)),
      ]),);
    
  }
}


