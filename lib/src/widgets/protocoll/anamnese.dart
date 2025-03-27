import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

import '../../models/icd.dart';
import '../../models/patient.dart';
import '../../models/protocol.dart';
import '../../repository/protocol_repository.dart';
import '../../repository/icd_repository.dart';
import 'mds_category_row.dart';

class AnamneseInputUserJourney extends StatefulWidget {
  final Patient patient;
  final Protocol protocol;

   const AnamneseInputUserJourney({super.key, required this.patient, required this.protocol});

  @override
  AnamneseInputUserJourneyState createState() => AnamneseInputUserJourneyState();
}

class AnamneseInputUserJourneyState extends State<AnamneseInputUserJourney> {

  final _notesController = TextEditingController();

  Icd? mainDiagnose;

  void _saveNotes() {
    if (_notesController.text.isNotEmpty) {
      print(_notesController.text);
      setState(() {
        widget.protocol.notes = _notesController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      _notesController.text = widget.protocol.notes??'';
    return Padding(
        padding: const EdgeInsets.all(16.0),

          child: Column(
            children: <Widget>[
               Text(AppLocalizations.of(context)!
            .enterProtocol(widget.patient.preName),),
  Expanded(
    child:
   SingleChildScrollView(
    child: Column(
      children: [
             

   TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.anamnese,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.errorNoText;
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _saveNotes,
                child: Text(AppLocalizations.of(context)!.addAnamnese),
              ),
           
             SizedBox(height: 8), 
            TextFormField(
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: "${AppLocalizations.of(context)!.mainDiagnose} as ICD ID",
                      ),
                      onFieldSubmitted: (text)  async {
                        if (text.isNotEmpty) {
                          mainDiagnose = await IcdRepository.getIcd(text);
                          setState(() {
                          widget.protocol.mainDiagnose = mainDiagnose;
                          widget.protocol.mds!.mdsFromPatient(widget.patient, widget.protocol);

                        }
                        );
                        }
                      },
                    ),
            
             SizedBox(height: 8), 
          TextFormField(
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: "${AppLocalizations.of(context)!.otherDiagnose} as ICD ID"
                      ),
                      keyboardType: TextInputType.number,

                      onFieldSubmitted: (text)  async {
                        if (text.isNotEmpty) {
                          
                          Icd icd  = await IcdRepository.getIcd(text);       
                          setState(() {
                          widget.protocol.otherDiagnoses.add(icd);
                          widget.protocol.mds!.mdsFromPatient(widget.patient, widget.protocol);
                              });
                                               }
                      },
                    ),
                       Row (children: [Text(AppLocalizations.of(context)!.mainDiagnose+": "+(widget.protocol.mainDiagnose?.title??'')), 
                                      Text("    "),     
                                      Text(AppLocalizations.of(context)!.otherDiagnose+": "),
                                      Text(widget.protocol.otherDiagnoses.map((e) => e.title+", ").toString()),

     ]),
                                      MdsRows(patient: widget.patient, protocol: widget.protocol)                    
],
          ),

    ),
  ),
      ],
    ),
   );    
  }
}