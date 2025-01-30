import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/treatment_station_list.dart';
import '../widgets/treatment_station_widget/treatment_station_widget_drop.dart';
import '../models/treatment_station.dart';
import '../repository/patient_repository.dart';
import '../widgets/app_bar.dart';
import '../widgets/patient_list/patint_list_view.dart';

class AllPatDeskScreen extends StatefulWidget {
  const AllPatDeskScreen({super.key});
  
  @override
  State<AllPatDeskScreen> createState() =>_AllPatDeskcreenState();
}

class _AllPatDeskcreenState extends State<AllPatDeskScreen> {
  TextEditingController editingController = TextEditingController();
  List<Patient> allPatients = [];
  List<Patient> filteredPatients = [];
   List<TreatmentStation> tsList = [];
  @override
  void initState() {
    super.initState();
    _loadPatients();
    //_loadTreatmentStations();
  }

  void _loadPatients() async {
    final patients = await PatientStorage.loadPatients();
    setState(() {
      filteredPatients = patients;
    });
  }

  // void _loadTreatmentStations() async {
  // tsList = await TreatmentStationList.loadTreatmentStations();
  // }
   
  @override
  Widget build(BuildContext context) {
    var treatmentStations =   context.watch<TreatmentStationList>();
   // treatmentStations.treatmentStations = tsList;
    return
    Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.allPatients),
      body:   
      Row(
        
        children: [

        Flexible(flex: 1, 
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
          Flexible(flex:1, child:Container()),  
          PatientListView(),
          Flexible(flex:3, child:Container()), 
        ]
        )), 
                 const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
        Expanded(flex: 2, child: 
         Column(
          children: [
          Wrap(
            spacing: 8.0,
            children: [
              ...treatmentStations.treatmentStations.map((treatmentStation) => TreatmentStationWidgetDrop(treatmentStation: treatmentStation)).toList(),

          ],
        ),
        ]
        ),
        ),
                   const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
      
            Flexible(flex: 1, child: Container( )),
      ]),);
    
  }
}


