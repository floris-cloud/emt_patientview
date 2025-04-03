import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import '../models/patient.dart';
import '../models/protocol.dart';

import 'all_patients_desktop.dart';

import '../widgets/protocoll/anamnese.dart';
import '../widgets/app_bar.dart';
import '../widgets/patient_change_user_journey.dart';
import '../widgets/protocoll/final_protocol.dart';
import '../widgets/protocoll/protocoll_input_user_journey.dart';


class ProtocolEntryScreen extends StatefulWidget {
  final Patient patient;
  const ProtocolEntryScreen({super.key, required this.patient});

  @override
  _ProtocolEntryScreenState createState() => _ProtocolEntryScreenState();

}
  class _ProtocolEntryScreenState extends State<ProtocolEntryScreen> {
    late Widget w;
    int _selectedIndex = 2;
    late Protocol protocol;
    late String title;  
    bool changeTitle = false;
    
    @override
    void initState() {
      super.initState();
    
        if(widget.patient.protocls.isNotEmpty){
        protocol = widget.patient.protocls.last;
        }
      else{
     protocol = Protocol(patientId: widget.patient.id);
     widget.patient.protocls = [protocol];
      }
      w = ProtocollInputUserJourney(patient: widget.patient, protocol: protocol);
      

    }
  Widget build(BuildContext context) {
    if(!changeTitle){
      title = AppLocalizations.of(context)!.patientData;
    }
    return Scaffold(
      appBar: CustomAppBar(
        title: title,
      ),
      body: Row(
          children: [
         NavigationRail(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
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
      NavigationRailDestination(
        icon: Icon(Icons.list_alt),
        label: Text(AppLocalizations.of(context)!.finalProtocol),
      )

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
            changeTitle = true;
            title = AppLocalizations.of(context)!.patientData;      
            break;
          case 2:
            w = ProtocollInputUserJourney(patient: widget.patient, protocol: protocol);
            changeTitle = true;
            title = AppLocalizations.of(context)!.medicalValues;  
            break;
          case 3:
            w = AnamneseInputUserJourney(patient: widget.patient, protocol: protocol);
            changeTitle = true;
            title = AppLocalizations.of(context)!.anamnese;
            break;
          case 4:
            w = LastProtocol(patient: widget.patient);
            changeTitle = true;
            title = AppLocalizations.of(context)!.finalProtocol;
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
    );
  }
  

}
