import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/patient.dart';
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
            children: [
              TreatmentStationWidgetDrop(treatmentStation: TreatmentStation(id: 1, name: "Intensivplatz", color: Colors.red)),
                TreatmentStationWidgetDrop(treatmentStation: TreatmentStation(id: 2, name: "Intensivplatz", color: Colors.red)),
                  TreatmentStationWidgetDrop(treatmentStation: TreatmentStation(id: 3, name: "Intensivplatz", color: Colors.red)),
                    TreatmentStationWidgetDrop(treatmentStation: TreatmentStation(id: 4, name: "Intensivplatz", color: Colors.green)),
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


