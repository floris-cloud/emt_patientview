// ignore_for_file: dead_code

import 'package:emt_patientview/src/models/treatment_station.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:emt_patientview/src/models/triage_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/treatment_station_list.dart';

class PatientDetail extends StatefulWidget{
   Patient? p;
  

   PatientDetail({super.key,  this.p});
  @override
  State<StatefulWidget> createState() {
    return _PatientDetailState();
  }
}
 class _PatientDetailState extends State<PatientDetail>{
  @override
  Widget build(BuildContext context) {
    Patient patient;
     bool isPatientDischarged = false;
    if(widget.p == null){
      return         Text(AppLocalizations.of(context)!.noPatientSelected);
    }
    else{
       patient = widget.p!;
    }
    double fontsize = 0.015*MediaQuery.of(context).size.width;
    return Column(
        children: [
         Row(
                children: [
                 CircleAvatar(
                      radius: fontsize*2,
                    ),
                  SizedBox(width: fontsize,),
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: '+patient.id.split('-').first, style: TextStyle(fontSize: fontsize),),
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
        SizedBox(height: fontsize,),
        Row(
          children: [
            Text(patient.triageCategory.name, style: TextStyle(fontSize: fontsize, backgroundColor: patient.triageCategory.getColor()),),
            SizedBox(width: fontsize,),
            Text( AppLocalizations.of(context)!.arrivedAt+': '+patient.formatedFirstContact(), style: TextStyle(fontSize: fontsize),),
          ],  
            ),
           SizedBox(height: fontsize,),
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(AppLocalizations.of(context)!.mainDiagnose,
             style: TextStyle(fontSize: fontsize/2),),
            Text(patient.protocls?[0].mainDiagnose?.title?? AppLocalizations.of(context)!.noData
            , style: TextStyle(fontSize: fontsize),),
              ],),
          ],)
          ,
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(AppLocalizations.of(context)!.anamnese,
             style: TextStyle(fontSize: fontsize/2),),
            Text(patient.protocls?[0].notes??  AppLocalizations.of(context)!.noData, style: TextStyle(fontSize: fontsize),),
              ],),
          ],),

          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              isPatientDischarged?
               TextButton(
                  child:Text("Test"),
                  onPressed: () {}
                ):
              TextButton(
                child: Row(children: [Icon(Icons.door_front_door),Text(AppLocalizations.of(context)!.discharge),]),
                onPressed: (){
                  patient.active = false;
                  patient.lastContact = DateTime.now();
                  Provider.of<TreatmentStationList>(context, listen: false).removePatientFromTreatmentStation(patient);
                  setState((){
                      isPatientDischarged = true;
                    }
                  );
                  
                },
              ) 
               
            ],
          ),
          ],        
 
    );
  }

}