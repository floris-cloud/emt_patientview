import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

import '../models/treatment_station.dart';
import '../widgets/app_bar.dart';
import '../widgets/patient_input/patient_input_controller.dart';
import '../widgets/patient_input/patient_input_view.dart';

class PatientInputScreen extends StatelessWidget {


  @override
  Widget build
  (BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.newPatient),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => PatientInputController(),
          child: PatientInputView(),
        ),
      ),
    );
  }
}
