import 'package:emt_patientview/src/models/triage_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../models/person.dart';
import '../models/treatment_station_list.dart';
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

          PatientListView(),

        ]
        )), 
                 const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
        Expanded(flex: 2, child: 
          TreatmentStationListView(),),
      
                   const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
                  Flexible(flex: 1, child: PatientDetail( p: Provider.of<TreatmentStationList>(context, listen: true).showPatient)),
      ]),);
    
  }
}


