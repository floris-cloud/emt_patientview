import 'package:emt_patientview/src/repository/patient_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/patient_list.dart';
import '../../models/triage_category.dart';
import '../add_patient_button.dart';
import '../patient_card_draggable.dart';


class PatientListView extends StatefulWidget {
  @override
  _PatientListViewState createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
  
  
  @override
  Widget build(BuildContext context) {
    var patientListModel = context.watch<PatientListModel>();
    final double maxHeigt = 0.25 * MediaQuery.of(context).size.height;
    final int patientCount = patientListModel.getFilteredPatients(false).length;
    final double itemHeight = 100.0 * patientCount;
    final double listHeight = (itemHeight < maxHeigt ? itemHeight : maxHeigt);
    bool sortPatientsTimeAsc = false;
    bool sortPatientsAlphabeticalAsc = true;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Text(AppLocalizations.of(context)!.allPatients, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Wrap(
            children: [                
              ...TriageCategory.values.map((TriageCategory triageCategory) =>
              FilterChip(
                
                label: Text(triageCategory.getText(context)),
                selectedColor: triageCategory.getColor(),
                selected: patientListModel.filterTriageCategory.contains(triageCategory),
                onSelected: (bool selected) {
                  setState(() {
                  if (selected) {
                    patientListModel.filterTriageCategory.add(triageCategory);
                  } else {
                    patientListModel.filterTriageCategory.remove(triageCategory);
                  }
                  });
                },
              )).toList(),
            ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              sortPatientsTimeAsc? IconButton(
                  tooltip: AppLocalizations.of(context)!.sortTimeAsc,
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {
                    
                    sortPatientsTimeAsc = false;
                    patientListModel.sortPatientsTimeAsc();

                 },
                ) :
                IconButton(
                  tooltip: AppLocalizations.of(context)!.sortTimeDesc,
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {
                    sortPatientsTimeAsc = true;
                    patientListModel.sortPatientsTimeDesc();
                  },
                ),
                sortPatientsAlphabeticalAsc? IconButton(
                  tooltip: AppLocalizations.of(context)!.sortAlphabeticalAsc,
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () {
                    sortPatientsAlphabeticalAsc = false;
                    patientListModel.sortPatientsAlphabeticalAsc();
                  },
                ) :
                IconButton(
                  tooltip: AppLocalizations.of(context)!.sortAlphabeticalDesc,
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () {
                    sortPatientsAlphabeticalAsc = true;
                    patientListModel.sortPatientsAlphabeticalDesc();
                  },
                ),
              ],),
           
                  patientListModel.getFilteredPatients(false).length > 0
                  ?
               
            Container(

              height: listHeight,
              
              child:
         ListView.builder(
                itemCount: patientCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PatientCardDraggable(patient: patientListModel.getFilteredPatients(false)[index]),
                  );
                },
              )
             
                    ) :  Text("No Patients found",
                        style: TextStyle( color: Colors.grey),
                      ),
         
            AddPatientButton(),
          ],
        );
      },
    );
  }
}