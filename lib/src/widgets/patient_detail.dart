
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

import 'package:emt_patientview/src/models/triage_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../models/patient_list.dart';
import '../models/treatment_station_list.dart';
import 'protocoll/final_protocol.dart';
import 'protocoll/medical_values_diagramm.dart';

class PatientDetail extends StatefulWidget{
   final Patient? patient;
  

   PatientDetail({super.key,  this.patient});
  @override
  State<StatefulWidget> createState() {
    return _PatientDetailState();
  }
}
 class _PatientDetailState extends State<PatientDetail>{

  @override
  Widget build(BuildContext context) {
    PdfProtocol pdfWidget;
    if(widget.patient == null){
      return         Text(AppLocalizations.of(context)!.noPatientSelected);
    }else{
      pdfWidget = PdfProtocol(patient: widget.patient!);
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
                        Text('ID: ${widget.patient!.id.split('-').first}', style: TextStyle(fontSize: fontsize),),
                        Text('${widget.patient!.surName}, ${widget.patient!.preName}', style: TextStyle(fontSize: fontsize),),
                        Row(
                          children: [
                            Text(widget.patient!.formatedBirthDate(), style: TextStyle(fontSize: fontsize),),
                            Icon(widget.patient!.gender.icon, size: fontsize,),
                          ],
                        ),
                      ],
                    ),
               
            ],
          )
        ,
        SizedBox(height: fontsize,),
    
            // SizedBox(
            //   height: fontsize*2,
            //   width: MediaQuery.of(context).size.width/8,
            //   child: 
              // Text(widget.patient!.triageCategory.name),),
             DropdownButtonFormField(
                        value: widget.patient!.triageCategory,
                        items: [
                         ...TriageCategory.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name, 
                                style: TextStyle(
                                   backgroundColor: category.getColor(),
                                  fontSize: fontsize *0.75,
                                ),
                              ),
                              );
                            })],
                          onChanged: (value) {
                            widget.patient!.setTriageCategory(value!);
                           Provider.of<PatientListModel>(context, listen: false).change(widget.patient!);
                           Provider.of<TreatmentStationList>(context, listen:false).notify();

                        },
                      // ),
                      ),
            // Text(widget.patient!.triageCategory.name, style: TextStyle(fontSize: fontsize/2, backgroundColor: widget.patient!.triageCategory.getColor()),),
        
            Text( '${AppLocalizations.of(context)!.arrivedAt}: ${formatedTime(widget.patient!.protocls.last.createdAt)}', style: TextStyle(fontSize: fontsize),),
         
       
          
           SizedBox(height: fontsize,),
          Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(AppLocalizations.of(context)!.mainDiagnose,
             style: TextStyle(fontSize: fontsize/2),),
            Text(widget.patient!.protocls.last.mainDiagnose?.title?? AppLocalizations.of(context)!.noData
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
            Text(widget.patient!.protocls.last.notes??  AppLocalizations.of(context)!.noData, style: TextStyle(fontSize: fontsize),),
              ],),
          ],),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 300,
            child: MedicalValuesDiagramm(patient: widget.patient!,protocol:  widget.patient!.protocls.last),
          ),  
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              Offstage(
                child: pdfWidget,
              ),
              Row(
                children: [
                  
              TextButton(
                child: Row(children: [Icon(Icons.door_front_door),Text(AppLocalizations.of(context)!.discharge),
                ]),
                onPressed: (){
                  widget.patient!.discharge();
                  Provider.of<PatientListModel>(context, listen: false).change(widget.patient!);
                  Provider.of<TreatmentStationList>(context, listen: false).removePatientFromTreatmentStation(widget.patient!);
                  Provider.of<TreatmentStationList>(context, listen: false).clearShowPatient();
                  setState(() {

                  }
                  );
                  
                },
              ), 
               TextButton(
                child: Row(children: [Icon(Icons.download),Text(AppLocalizations.of(context)!.downloadProtocol),
                ]),
                onPressed: (){
                  pdfWidget.saveFile();

                  setState(() {
                  }
                  );
                  
                },
              )
                ],
              )
               
            ],
          ),
          ],        
 
    );
  }

}

  String formatedTime(DateTime time) { 
    return "${time.day.toString().padLeft(2, '0')}${time.hour.toString().padLeft(2, '0')}${time.minute.toString().padLeft(2, '0')}";
  }