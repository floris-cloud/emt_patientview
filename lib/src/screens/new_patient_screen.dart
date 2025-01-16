import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/treatment_station.dart';
import '../widgets/app_bar.dart';
import '../widgets/patient_input/patient_input_controller.dart';
import '../widgets/patient_input/patient_input_view.dart';

class PatientInputScreen extends StatelessWidget {
    final TreatmentStation? treatmentStation;
    
  const PatientInputScreen({Key? key, this.treatmentStation}) : super(key: key);

  @override
  Widget build
  (BuildContext context) {
    print(treatmentStation?.name ?? 'No treatment station');
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.newPatient),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => PatientInputController(treatmentStation: treatmentStation),
          child: PatientInputView(),
        ),
      ),
    );
  }
}
