import 'package:flutter/material.dart';

import '../../models/icd.dart';
import '../../models/patient.dart';
import '../../models/protocol.dart';
import '../../repository/protocol_repository.dart';
import '../../repository/icd_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AnamneseInputUserJourney extends StatefulWidget {
  final Patient patient;

   const AnamneseInputUserJourney({super.key, required this.patient});

  @override
  AnamneseInputUserJourneyState createState() => AnamneseInputUserJourneyState();
}

class AnamneseInputUserJourneyState extends State<AnamneseInputUserJourney> {

  final _notesController = TextEditingController();
  Icd? mainDiagnose;

  Future<void> _submitForm() async {
      Protocol protocol = await ProtocolRepository.loadProtocol(
              widget.patient,) ??
          Protocol(notes: _notesController.text, patientId: widget.patient.id, mainDiagnose: mainDiagnose);
      ProtocolRepository.saveProtocol(protocol);
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: <Widget>[
               Text(AppLocalizations.of(context)!
            .enterProtocol(widget.patient.preName),),

               Padding(
                      padding: const EdgeInsets.all(8.0),
                child:   TextFormField(
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
              ),
              SearchBar(
                onSubmitted: (String value) async {
                   mainDiagnose = await IcdRepository.getIcd(value);
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(AppLocalizations.of(context)!.submit),
              ),
            ],
          ),
        ),
      
    );
  }
}