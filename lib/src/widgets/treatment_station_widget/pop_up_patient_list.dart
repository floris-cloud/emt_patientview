import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../models/patient_list.dart';
import '../../models/patient.dart';

class PopUpPatientList extends StatefulWidget {
  final Function(Patient) onPatientSelected;

  const PopUpPatientList({Key? key, required this.onPatientSelected}) : super(key: key);

  @override
  _PopUpPatientListState createState() => _PopUpPatientListState();
}

class _PopUpPatientListState extends State<PopUpPatientList> {
  @override
  Widget build(BuildContext context) {
    var patientListModel = Provider.of<PatientListModel>(context);
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.allPatients,),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: patientListModel.patients.length,
          itemBuilder: (context, index) {
            final patient = patientListModel.patients[index];
            return ListTile(
              title: Text('${patient.preName} ${patient.surName}'),
              onTap: () {
                widget.onPatientSelected(patient);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}