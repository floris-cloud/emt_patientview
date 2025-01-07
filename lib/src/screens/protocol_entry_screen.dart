import 'package:flutter/material.dart';

import '../models/patient.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/patient_change_user_journey.dart';
import '../widgets/protocoll_input_user_journey.dart';


class ProtocolEntryScreen extends StatelessWidget {
  final Patient patient;
  const ProtocolEntryScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.patientInputTitle),
      ),
      body:Expanded(
     
        child: ListView(         
        children: [
          PatientChangeUserJourney(patient: patient),
   
          ProtocollInputUserJourney(patient: patient),
   
        ],
      ),
        ),
    );
  }
}
