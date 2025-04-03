import 'package:flutter/material.dart';
import '../../models/medical_values.dart';
import '../../models/patient.dart';
import '../../models/protocol.dart';
import '../../repository/protocol_repository.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import 'medical_values_diagramm.dart';
import '../medicalValueView.dart';
class ProtocollInputUserJourney extends StatefulWidget {
  final Patient patient;
  final Protocol protocol;
   const ProtocollInputUserJourney({super.key, required this.patient, required this.protocol});

  @override
  ProtocollInputUserJourneyState createState() => ProtocollInputUserJourneyState();
}

class ProtocollInputUserJourneyState extends State<ProtocollInputUserJourney> {
  final _formKey = GlobalKey<FormState>();
  // final _notesController = TextEditingController();
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
      ProtocolRepository.saveProtocol(widget.protocol);
      setState(() {
        widget.protocol.medicalValuesList.add(medicalValues);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Text(AppLocalizations.of(context)!
            .enterProtocol(widget.patient.id.split('-').first),),
            SizedBox(height: 8),
            //all medicalValues
            // ListView(
            //   shrinkWrap: true,
            //   children: [
            //       ...widget.protocol.medicalValuesList.map((medicalValue) {
            //     return Medicalvalueview(medicalValue: medicalValue);

            //       })
            //   ],
            // ),
        Container(
          height: 300,
          width: 600,
          child: MedicalValuesDiagramm(patient: widget.patient, protocol: widget.protocol),),
    //AB
    
     Row(
     children: [  //AF
       Container(
        constraints: BoxConstraints(
          maxWidth:  0.25*MediaQuery.of(context).size.width,
          minWidth: 0.15*MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(2),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                      controller: _respiratoryRateController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText:
                            AppLocalizations.of(context)!.respiratoryRate,
                      ),
                      keyboardType: TextInputType.number,
                    ),
               SizedBox(height: 8),
      Text(
        "1/min",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
          ],
        ), 
       ),
      //SPO2
      SizedBox(width: 8),
       Container(
        constraints: BoxConstraints(
          maxWidth:  0.25*MediaQuery.of(context).size.width,
          minWidth: 0.15*MediaQuery.of(context).size.width,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                      controller: _oxygenSaturationController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText:
                            AppLocalizations.of(context)!.oxygenSaturation,
                      ),
                      keyboardType: TextInputType.number,
                    ),
               SizedBox(height: 8),
      Text(
        "%",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
          ],
        ), 
       ),
     ],
     ),
    
      SizedBox(height: 8),
      //NIBP
     Container(
      constraints: BoxConstraints(
        maxWidth:  0.25*MediaQuery.of(context).size.width,
        minWidth: 0.15*MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
     padding: const EdgeInsets.all(2),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations.of(context)!.nibp,
        style: TextStyle(fontWeight: FontWeight.bold)
      ),
SizedBox(height: 8),
    Wrap(
  
  direction: Axis.horizontal,
  spacing: 8.0,
  crossAxisAlignment: WrapCrossAlignment.start,
  children: [
    Container(
          constraints: BoxConstraints(
            maxWidth:  0.1*MediaQuery.of(context).size.width,
          ),
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
    ),
       Container(
          constraints: BoxConstraints(
            maxWidth:  0.1*MediaQuery.of(context).size.width,
          ),
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
            if (double.tryParse(_systolicController.text) != null) {
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
  ],
),

      SizedBox(height: 8),
      Text(
        AppLocalizations.of(context)!.mmHg,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
    ],
  ),
),         

SizedBox(height: 8),
            Row(
              children: [
              //Pulse
              Container(
                constraints: BoxConstraints(
                  maxWidth:  0.25*MediaQuery.of(context).size.width,
                  minWidth: 0.15*MediaQuery.of(context).size.width,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _pulseController,
                      decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.pulse,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "1/min",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 8),
                            
              ],
           
             
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  //Temperature
                  Container(
                    constraints: BoxConstraints(
                      maxWidth:  0.25*MediaQuery.of(context).size.width,
                      minWidth: 0.15*MediaQuery.of(context).size.width,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _temperatureController,
                          decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                            labelText: AppLocalizations.of(context)!.temperature,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "°C",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  //Blood Sugar
                  Container(
                    constraints: BoxConstraints(
                      maxWidth:  0.25*MediaQuery.of(context).size.width,
                      minWidth: 0.15*MediaQuery.of(context).size.width,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _bloodSugarController,
                          decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                            labelText: AppLocalizations.of(context)!.bloodSugar,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "mg/dl",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                        )
                  ),

                ],
              ),
              SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size( 0.1* MediaQuery.of(context).size.width, 0.05 * MediaQuery.of(context).size.height),
                ),
                onPressed: _submitForm,
                child: Text(AppLocalizations.of(context)!.submit),
              ),
            ],
          ),
        ),
      
    );
  }
}