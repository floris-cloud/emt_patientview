import 'package:flutter/material.dart';
import '../widgets/patient_input_user_journey.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PatientInputScreen extends StatelessWidget {
  const PatientInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: PatientInputUserJourney(),
      ),
    );
  }
}
