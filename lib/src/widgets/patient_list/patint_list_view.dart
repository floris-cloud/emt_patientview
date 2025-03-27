import 'package:emt_patientview/src/repository/patient_repository.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_symbols_icons/symbols.dart';


import '../../models/patient.dart';
import '../../models/patient_list.dart';
import '../../models/triage_category.dart';
import '../add_patient_button.dart';
import '../patient_card_draggable.dart';


class PatientListView extends StatefulWidget {
  @override
  _PatientListViewState createState() => _PatientListViewState();
}

class _PatientListViewState extends State<PatientListView> {
    bool sortPatientsTimeAsc = true;
    bool sortPatientsAlphabeticalAsc = true;
    bool filterNoTreatmentStation = true;
    bool sortPatientsTriageCategoryAsc = true;

  //   final patients = await PatientStorage.loadPatients();
  //   setState(() {
  //     // _patientsList.patient = patients;
  //   });
  //   }
  @override
  Widget build(BuildContext context) {
    var patientListModel = context.watch<PatientListModel>();
  
    final double maxHeigt = 0.5 * MediaQuery.of(context).size.height;
    final int patientCount = patientListModel.filteredPatients(filterNoTreatmentStation).length;
    final double itemHeight = 100.0 * patientCount;
    final double listHeight = (itemHeight < maxHeigt ? itemHeight : maxHeigt);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Text(AppLocalizations.of(context)!.allPatients, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            Wrap(
            children: [                
              ...TriageCategory.values.map((TriageCategory triageCategory) =>
        
              FilterChip(
                elevation: 15.0,
                showCheckmark: false,
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
              ),
            ),
            ],
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              sortPatientsTimeAsc? IconButton(
                  tooltip: AppLocalizations.of(context)!.sortTimeAsc,
                  icon: Icon(Symbols.timer_arrow_up),
                  onPressed: () {
                   setState(() {
                    patientListModel.sortPatientsTimeAsc();
                    sortPatientsTimeAsc = false;
                   }); 

                 },
                ) :
                IconButton(
                  tooltip: AppLocalizations.of(context)!.sortTimeDesc,
                  icon: Icon(Symbols.timer_arrow_down_rounded),
                  onPressed: () {
                    setState(() {
                    sortPatientsTimeAsc = true;
                    patientListModel.sortPatientsTimeDesc();
                  },
                );}
                ),
                sortPatientsAlphabeticalAsc? IconButton(
                  tooltip: AppLocalizations.of(context)!.sortAlphabeticalAsc,
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () {
                    setState(() {
                    sortPatientsAlphabeticalAsc = false;
                    patientListModel.sortPatientsAlphabeticalAsc();
                    },);
                  },
                ) :
                IconButton(
                  tooltip: AppLocalizations.of(context)!.sortAlphabeticalDesc,
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () {
                    setState(() {
                    sortPatientsAlphabeticalAsc = true;
                    patientListModel.sortPatientsAlphabeticalDesc();
                    },);
                  },
                ),
                IconButton(
                  tooltip: filterNoTreatmentStation ? AppLocalizations.of(context)!.filterTreatmentStation : AppLocalizations.of(context)!.filterNoTreatmentStation,
                  icon: Icon(Icons.medical_services),
                  color: filterNoTreatmentStation ? Colors.red : Colors.grey,
                  onPressed: () {
                    setState(() {
                    filterNoTreatmentStation = !filterNoTreatmentStation;
                    },);
                  },
                ),
              ],),
                  patientListModel.filteredPatients(filterNoTreatmentStation).isNotEmpty
                  ?
               
            Container(
              height: listHeight,
              
              child:
         ListView.builder(
                itemCount: patientCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PatientCardDraggable(patient: patientListModel.filteredPatients(filterNoTreatmentStation)[index]),
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