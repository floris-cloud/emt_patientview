import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.allPatients),
      body:   
      Row(
        children: [        Flexible(flex: 1, 
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
          TreatmentStationListView(),),
      
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


