import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/icd.dart';
import '../../models/patient.dart';
import '../../models/protocol.dart';
import '../../repository/protocol_repository.dart';
import '../../repository/icd_repository.dart';

class AnamneseInputUserJourney extends StatefulWidget {
  final Patient patient;

   const AnamneseInputUserJourney({super.key, required this.patient});

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
        widget.patient.protocls!.first.notes = _notesController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
      _notesController.text = widget.patient.protocls!.first.notes??'';
    return Padding(
        padding: const EdgeInsets.all(16.0),
        // child: Form(
          child: Column(
            children: <Widget>[
               Text(AppLocalizations.of(context)!
            .enterProtocol(widget.patient.preName),),
  //  Text("Bestehende Anamesen"),
  //   Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: Theme.of(context).dividerColor,
  //         width: 1.0,
  //       ),),
  //               child:
  //   Column(children: [
                  
  //                 ...widget.patient.protocls!.map((protocol) => Text(protocol.notes??''))

  //               ],),),
  //               SizedBox(height: 8),
               
   Row (children: [Text(AppLocalizations.of(context)!.mainDiagnose+(widget.patient.protocls!.first.mainDiagnose?.title??'')), 
   Text(AppLocalizations.of(context)!.otherDiagnose),
   Text(widget.patient.protocls!.first.otherDiagnoses.map((e) => e.title).toString()),

     ]),
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
                      keyboardType: TextInputType.number,

                      onFieldSubmitted: (text)  async {
                        if (text.isNotEmpty) {
                          mainDiagnose = await IcdRepository.getIcd(text);
                          setState(() {
                          widget.patient.protocls![0].mainDiagnose = mainDiagnose;
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
                          widget.patient.protocls![0].otherDiagnoses.add(icd);
                              });
                                               }
                      },
                    ),
    
                     
],
          ),

    );
  }
}