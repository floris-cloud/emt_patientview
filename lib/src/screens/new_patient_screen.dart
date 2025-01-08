import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/appBar.dart';
import '../widgets/patient_input/patient_input_controller.dart';
import '../widgets/patient_input/patient_input_view.dart';

class PatientInputScreen extends StatelessWidget {
  const PatientInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
