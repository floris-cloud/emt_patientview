import 'package:flutter/material.dart';

import '../themes/app_color.dart';
import '../screens/new_patient_screen.dart';

class AddPatientButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
   
    IconButton(
      icon: Icon(Icons.add),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColor.buttonBackgroundColor),
        ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientInputScreen(),
          ),
        );
      },    );
  }
}