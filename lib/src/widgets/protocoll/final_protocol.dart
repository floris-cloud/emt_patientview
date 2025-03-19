
import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:emt_patientview/src/widgets/patient_card_widget.dart';
import 'package:emt_patientview/src/widgets/protocoll/mds_selection_dialog.dart';

import '../../models/mds.dart';
import '../../models/patient.dart';
import '../../models/protocol.dart';
import 'medical_values_diagramm.dart';
import 'patient_info.dart';

class FinalProtocol extends StatefulWidget{
  final Patient patient;
  FinalProtocol({super.key, required this.patient});

  @override
  State<FinalProtocol> createState() => _FinalProtocolState();

}

class _FinalProtocolState extends State<FinalProtocol> {
  late Protocol protocol;
 
  checkMDS(){
        if(protocol.mds == null){
            protocol.mds = MDS(age: widget.patient.getAge(), id: widget.patient.id);
            protocol.mds!.mdsFromPatient(widget.patient, protocol);
  }
  }
   @override
  initState(){
    super.initState();
    protocol = widget.patient.protocls.last;
    checkMDS();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        PatientInformation(patient: widget.patient),
        // MedicalValuesDiagramm(patient: patient),
        Row(
          children: [
              Text(AppLocalizations.of(context)!.allProtocolls),
            ...widget.patient.protocls.map((Protocol p)
              => 
                ElevatedButton(onPressed: (){
                  setState(() {
                    protocol = p;
                    checkMDS();
                  });
                },
                 child: 
                Text(p.createdAt.day.toString()+"."+p.createdAt.month.toString()))
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
    return Column(
      children: [

    Text('Anamnese: ${protocol.notes ?? ''}',),
        Text('Diagnose: ${protocol.mainDiagnose ?? ''}',),
        Container(
          width: 600,
          height: 300,
          child: MedicalValuesDiagramm(patient: patient, protocol: protocol),
        ),
             Row(children: [
            Text("MDS:"),
            ...protocol.mds!.mdsList.map((e) => Text(e.toString()))
          ],),
         ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MdsSelectionDialog(patient: patient, protocol: protocol);
                  },
                );
              },
     
              child: Text('MDS'),
            ),
         ElevatedButton(onPressed: (){
          patient.protocls.last.sendProtocol();
         }, child: Text('Send Protocoll'),)
                 
      ],
    );
  }
}

class PdfProtocol extends StatelessWidget{
  final Patient patient;
  PdfProtocol({super.key, required this.patient});
  final ExportDelegate exportDelegate = ExportDelegate();
    @override
  Widget build(BuildContext context) {
    return ExportFrame(
  frameId: 'someFrameId',
  exportDelegate: exportDelegate,
  child: FinalProtocol(patient: patient)
);
  }
saveFile() async{
print("save File");
final pdf = await exportDelegate.exportToPdfDocument('someFrameId');
final bytes  = await pdf.save();
String name = patient.surName+"_"+patient.preName+"_"+patient.protocls.last.createdAt.day.toString()+"."+patient.protocls.last.createdAt.month.toString()+"_protocoll.pdf";
FileSaver.instance.saveFile(name: name, bytes:bytes, customMimeType: 'application/pdf');
}
}



