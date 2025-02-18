import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:emt_patientview/src/models/triage_category.dart';
import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientDetail extends StatelessWidget{
  final Patient patient;
  
  const PatientDetail({super.key, required  this.patient});
  
  @override
  Widget build(BuildContext context) {
    double fontsize = 0.015*MediaQuery.of(context).size.width;
    return Column(
        children: [
         Row(
                children: [
                 CircleAvatar(
                      radius: 50.0,
                    ),

                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: '+patient.id, style: TextStyle(fontSize: fontsize),),
                        Text(patient.surName+', '+patient.preName, style: TextStyle(fontSize: fontsize),),
                        Row(
                          children: [
                            Text(patient.formatedBirthDate(), style: TextStyle(fontSize: fontsize),),
                            Icon(patient.gender.icon, size: fontsize,),
                          ],
                        ),
                      ],
                    ),
               
            ],
          )
        ,
        Row(
          children: [
            Text(patient.triageCategory.name, style: TextStyle(fontSize: fontsize, backgroundColor: patient.triageCategory.getColor()),),
            Text( AppLocalizations.of(context)!.arrivedAt+': '+patient.formatedFirstContact(), style: TextStyle(fontSize: fontsize),),
          ],  
            ),

          Row(children: [
            Text(AppLocalizations.of(context)!.mainDiagnose,
             style: TextStyle(fontSize: fontsize),),
          ],)
          ],        
 
    );
  }
}