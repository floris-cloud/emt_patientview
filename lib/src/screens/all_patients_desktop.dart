import 'package:flutter/material.dart';

import '../models/patient.dart';
import '../models/person.dart';
import '../models/triage_category.dart';
import '../repository/patient_repository.dart';
//import '../widgets/patient_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/patientCard_widget.dart';
import '../widgets/patient_widget_small.dart';

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
    //final patients = await PatientStorage.loadPatients();
    setState(() {
      //allPatients = patients;
      //filteredPatients = patients;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.allPatientsTitle),
      ),
      body: 
      
      Row(
        children: [

        Flexible(flex: 1, 
        child: Column(children: [
          Flexible(flex:1, child:Container(color: Colors.red,)), 
          PatientCard
            (patient: Patient(surName: "Müller", preName: "preName", gender: Gender.male, triageCategory: TriageCategory(2)),),
          Flexible(flex:3, child:Container(color: Colors.red,)), 
        ]
        )), 
        Flexible(flex: 2, child: Container( color: Colors.blue)),
            Flexible(flex: 1, child: Container( color: Colors.red)),
      ])
    );
  }
}


