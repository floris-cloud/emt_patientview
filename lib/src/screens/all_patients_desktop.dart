import 'dart:async';
import 'package:flutter/foundation.dart'; 

import 'package:emt_patientview/src/models/triage_category.dart';
import 'package:emt_patientview/src/widgets/pop_up_new_Patient_from_card.dart';
import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../models/patient_list.dart';
import '../models/person.dart';
import '../models/treatment_station_list.dart';
import '../repository/ws_api.dart';
import '../widgets/patient_detail.dart';
import '../widgets/treatment_station_list_view.dart';
import '../widgets/app_bar.dart';
import '../widgets/patient_list/patint_list_view.dart';

class AllPatDeskScreen extends StatefulWidget {
  const AllPatDeskScreen({super.key});
  @override
  State<AllPatDeskScreen> createState() =>_AllPatDeskcreenState();
}
class _AllPatDeskcreenState extends State<AllPatDeskScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.overView),
      body:   
      Row(
        children: [        Flexible(flex: 1, 
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
          Consumer<PatientListModel>(
    builder: (context, patientListModel, child) {
      return PatientListView();
    }
  ),

        ]
        )), 
                 const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
  if(false)...[
  StreamBuilder(
  stream: webSocketStream,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      // Dialog nach dem Build-Prozess anzeigen
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => PopUpNewPatientFromCard(pateintData: snapshot.data)
        );
      });
    }
    return Container();
  },
)
  ],
    
        Expanded(flex: 2, child: 
          TreatmentStationListView(),),
      
                   const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
                  Flexible(flex: 1, child: Consumer<TreatmentStationList>(
    builder: (context, treatmentStationList, child) {
      return PatientDetail(patient: treatmentStationList.showPatient);
    },
  )),
      ]),);
  
  }
}


