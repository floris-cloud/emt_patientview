
import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

import 'package:emt_patientview/src/widgets/patient_card_widget.dart';
import 'package:emt_patientview/src/widgets/protocoll/mds_selection_dialog.dart';

import '../../models/mds.dart';
import '../../models/patient.dart';
import '../../models/protocol.dart';
import 'mds_category_row.dart';
import 'medical_values_diagramm.dart';
import 'patient_info.dart';

class LastProtocol extends StatefulWidget{
  final Patient patient;
  LastProtocol({super.key, required this.patient});

  @override
  State<LastProtocol> createState() => _LastProtocolState();

}

class _LastProtocolState extends State<LastProtocol> {
  late Protocol protocol;
 
  checkMDS(){

    protocol.mds ??= MDS(age: widget.patient.getAge(), id: widget.patient.id);
    protocol.mds!.mdsFromPatient(widget.patient, protocol);
  }
   @override
  initState(){
    super.initState();
    if(widget.patient.protocls.isEmpty){
      print("no protocol");
      protocol = Protocol(patientId: widget.patient.id);
      widget.patient.protocls.add(protocol);
    }
    protocol = widget.patient.protocls.last;
    checkMDS();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return
    Column(
      children: [
        PatientInformation(patient: widget.patient),
        // MedicalValuesDiagramm(patient: widget.patient, protocol: widget.patient.protocls.last,),
        // Text(AppLocalizations.of(context)!.allProtocolls),
        Row(
          children: [
              Text(AppLocalizations.of(context)?.allProtocolls??"Alle Protokolle"),
            ...widget.patient.protocls.map((Protocol p)
              {
                print(p.toJson());
              return  
              ElevatedButton(onPressed: (){
                  setState(() {
                    protocol = p;
                    checkMDS();
                  });
                },
                 child: 
                Text("${p.createdAt.day}.${p.createdAt.month}"));
              } 
            ),
          ],
        ),
        ProtocollView(protocol: widget.patient.protocls.last, patient: widget.patient,)
      ]
    );
  }
}

class ProtocollView extends StatelessWidget{
  final Patient patient;
  final Protocol protocol;

  const ProtocollView({super.key, required this.protocol, required this.patient});
  @override
  Widget build(BuildContext context) {
    return 
Expanded(child: 
  SingleChildScrollView(
    child: 
    Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
    Text('Anamnese: ${protocol.notes ?? ''}',),
    Text(AppLocalizations.of(context)?.mainDiagnose??"Hauptdiagnose: ${protocol.mainDiagnose?.title??''}"), 
    Text(AppLocalizations.of(context)?.otherDiagnose??"Nebendiagnose"+": "),
   Text(protocol.otherDiagnoses.map((e) => "${e.title}, ").toString()),
       Center(child: 
        Container(
          width: 600,
          height: 300,
          child: MedicalValuesDiagramm(patient: patient, protocol: protocol),
        ),
      ),
        MdsRows(patient: patient,protocol: protocol,),
         ElevatedButton(onPressed: (){
          protocol.sendProtocol();
         }, child: Text('Send Protocoll'),)
      
      ],
    ),
  )
);
  }
}

class PdfProtocol extends StatelessWidget{
  final Patient patient;
  PdfProtocol({super.key, required this.patient});
  final ExportDelegate exportDelegate = ExportDelegate();
    @override
  Widget build(BuildContext context) {
    Protocol protocol = patient.protocls.last;
    return ExportFrame(
  frameId: 'someFrameId',
  exportDelegate: exportDelegate,
  child:  
    Column(
      children: [
        PatientInformation(patient: patient),

        Row(
          children: [
              Text("Alle Protokolle"),
            ...patient.protocls.map((Protocol p)
               => Text("${p.createdAt.day}.${p.createdAt.month}")
              
            ),
          ],
        ),
        Text('Anamnese: ${protocol.notes ?? ''}',),
        Row(children: [
        Text("${AppLocalizations.of(context)!.mainDiagnose}: "),
        Text(protocol.mainDiagnose?.title??''), 
        Spacer(),
        Text(protocol.otherDiagnoses.map((e) => "${e.title}, ").toString()),
          
        ],),
            Text("${AppLocalizations.of(context)!.otherDiagnose}: "), 
                  ...protocol.medicalValuesList.map((medicalValue) => Column(children: [Text(medicalValue.toString()),Divider() ])
),
    ...MDS.getMDSCategory().map((category){
      return Row(
        children:[
        Text("${category.title}: "),
         
          ...(protocol.mds?.mdsList.where((mds) => category.values.contains(mds)).map((e) => Text(e.name)) ?? [Text(" ")]),
        ] 
      );
    
    }),
   

  
      
      ]
    ),
    );
}

saveFile() async{
final pdf = await exportDelegate.exportToPdfDocument('someFrameId');
final bytes  = await pdf.save();
String name = "${patient.surName}_${patient.preName}_${patient.protocls.last.createdAt.day}.${patient.protocls.last.createdAt.month}_protocoll.pdf";
FileSaver.instance.saveFile(name: name, bytes:bytes, customMimeType: 'application/pdf');
}
}



