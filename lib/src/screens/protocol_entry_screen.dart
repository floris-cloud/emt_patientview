import 'package:emt_patientview/src/screens/all_patients_desktop.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/protocoll/anamnese.dart';
import '../widgets/app_bar.dart';
import '../widgets/patient_change_user_journey.dart';
import '../widgets/protocoll/protocoll_input_user_journey.dart';


class ProtocolEntryScreen extends StatefulWidget {
  final Patient patient;
  const ProtocolEntryScreen({super.key, required this.patient});

  @override
  _ProtocolEntryScreenState createState() => _ProtocolEntryScreenState();

}
  class _ProtocolEntryScreenState extends State<ProtocolEntryScreen> {
    late Widget w;
    int _selectedIndex = 1;
    @override
    void initState() {
      super.initState();
      w = ProtocollInputUserJourney(patient: widget.patient);
      
    }
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.patientInputTitle
      ),
      body:Expanded(
     
        child: Row(
          children: [
         NavigationRail(
      selectedIndex: _selectedIndex,
      useIndicator: true,
      labelType: NavigationRailLabelType.all,
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.home, semanticLabel: AppLocalizations.of(context)!.allPatients),
        label: Text(AppLocalizations.of(context)!.allPatients),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.person),
        label: Text(AppLocalizations.of(context)!.patientData),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.medical_services, semanticLabel: AppLocalizations.of(context)!.medicalValues,),
        label: Text(AppLocalizations.of(context)!.medicalValues),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.notes),
        label: Text(AppLocalizations.of(context)!.anamnese),
      ),
    ],
    onDestinationSelected: (int index) {
      setState(() {
         _selectedIndex = index;
        switch (index) {
          case 0:
            Navigator.push( context,
          MaterialPageRoute(
            builder: (context) => AllPatDeskScreen(),
          ),);
            break;
          case 1:          
            w = PatientChangeUserJourney(patient: widget.patient);         
            break;
          case 2:
            w = ProtocollInputUserJourney(patient: widget.patient);
            break;
          case 3:
            w = AnamneseInputUserJourney(patient: widget.patient);
            break;
        }
      });
    }, 
  
  ),
                         const VerticalDivider(
            width: 20,
            thickness: 1,
            indent: 20,
            endIndent: 0,
          ),
          Flexible(flex:5,
          child: w
          )
          ],
                   
       
        )
      ),
    );
  }
  

}
