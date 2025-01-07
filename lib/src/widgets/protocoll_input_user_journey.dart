import 'package:flutter/material.dart';
import '../models/medical_values.dart';
import '../models/patient.dart';
import '../models/protocol.dart';
import '../repository/protocol_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ProtocollInputUserJourney extends StatefulWidget {
  final Patient patient;

   const ProtocollInputUserJourney({super.key, required this.patient});

  @override
  ProtocollInputUserJourneyState createState() => ProtocollInputUserJourneyState();
}

class ProtocollInputUserJourneyState extends State<ProtocollInputUserJourney> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _pulseController = TextEditingController();
  final _oxygenSaturationController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _bloodSugarController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Collecting data from the text fields

      MedicalValues medicalValues = MedicalValues(
        systolic: int.tryParse(_systolicController.text),
        diastolic: int.tryParse(_diastolicController.text),
        respiratoryRate: int.tryParse(_respiratoryRateController.text),
        pulse: int.tryParse(_pulseController.text),
        oxygenSaturation: double.tryParse(_oxygenSaturationController.text),
        temperature: double.tryParse(_temperatureController.text),
        bloodSugar: double.tryParse(_bloodSugarController.text),
        createdAt: DateTime.now(),);

      Protocol protocol = await ProtocolRepository.loadProtocol(
              widget.patient,) ??
          Protocol(notes: _notesController.text, patientId: widget.patient.id);
      protocol.addMedicalValues(medicalValues);
      ProtocolRepository.saveProtocol(protocol);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
               Text(AppLocalizations.of(context)!
            .enterProtocol(widget.patient.preName),),
          
              Row(
                children: [
                  
                      
                  Text(AppLocalizations.of(context)!.bloodPressure),
                  Expanded(child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 8.0),
                    child: TextFormField(
                      
                      controller: _systolicController,
                      decoration: InputDecoration(
                      
                      border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.systolic,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (double.tryParse(value) == null) {
                            return AppLocalizations.of(context)!
                                .errorNotNumeric;
                          }
                        }
                        return null;
                      },
                    ),
                  ),),
                  Expanded(child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,right: 8.0),
                    child: TextFormField(
                      controller: _diastolicController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.diastolic,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (double.tryParse(value) == null) {
                            return AppLocalizations.of(context)!
                                .errorNotNumeric;
                          }
                          if (double.tryParse(_systolicController.text) !=
                              null) {
                            if (double.parse(_systolicController.text) <
                                double.parse(value)) {
                              return AppLocalizations.of(context)!
                                  .errorDisGreaterSys;
                            }
                          }
                        }
                        return null;
                      },
                    ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _respiratoryRateController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText:
                            AppLocalizations.of(context)!.respiratoryRate,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ),
                  Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _pulseController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.pulse,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ),
                  Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _oxygenSaturationController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText:
                            AppLocalizations.of(context)!.oxygenSaturation,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _temperatureController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.temperature,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ),

                  Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _bloodSugarController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.bloodSugar,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ),
                ],
              ),
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