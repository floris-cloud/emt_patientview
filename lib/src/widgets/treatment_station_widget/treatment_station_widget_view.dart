import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/patient_list.dart';
import '../../models/triage_category.dart';
import '../../models/treatment_station.dart';
import '../../models/patient.dart';
import '../../screens/new_patient_screen.dart';
import '../../screens/protocol_entry_screen.dart';
import 'pop_up_patient_information.dart';
import 'pop_up_patient_list.dart';

class TreatmentStationView extends StatefulWidget {
  final TreatmentStation treatmentStation;

  const TreatmentStationView({super.key, required this.treatmentStation});
  
  @override
  State<StatefulWidget> createState() {
    return _TreatmentStationViewState();
  }
}
class _TreatmentStationViewState extends State<TreatmentStationView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 200,
      child: Column(
        children: [
          Container(
            color: widget.treatmentStation.color,
          
            child: Text(
              '${widget.treatmentStation.id} ${widget.treatmentStation.name}',
              textAlign: TextAlign.left,
            ),
          ),
          Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                color: widget.treatmentStation.patient?.triageCategory.getColor()?? Theme.of(context).secondaryHeaderColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () {
                        // Handle info button press
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                            if(widget.treatmentStation.patient != null) {
                              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopUpPatientInformation(
                    patient: widget.treatmentStation.patient!,
                    onPatientUpdated: (Patient updatedPatient) {
                      setState(() {
                        widget.treatmentStation.patient = updatedPatient;
                      });
                    },
                  );
                },
              );
                            }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                       color: widget.treatmentStation.patient != null ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                      onPressed: () {
                        widget.treatmentStation.patient = null;
                        setState((){});
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      color: widget.treatmentStation.patient == null ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,  
                      onPressed: () {
                        if (widget.treatmentStation.patient == null) {
                                    showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopUpPatientList(
                    onPatientSelected: (Patient patient) {
                      setState(() {
                        widget.treatmentStation.patient = patient;
                      });
                    },
                  );
                },
              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
            flex: 5,
            child:Column(
            children: [
              Text(
                    (widget.treatmentStation.patient?.surName ?? "") + ", " + (widget.treatmentStation.patient?.preName ?? ""),
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(children: [
                    
                  Text(
                    widget.treatmentStation.patient?.formatedBirthDate() ?? "",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),Icon(widget.treatmentStation.patient?.gender.icon),
                
                  Text(
                    widget.treatmentStation.patient?.diagnose ?? " ",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  ],),
           
                  TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Weitere Diagnosen',
                ),
              ),
             
           
           TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Allergien/Infektionen',
                ),
              ), 
          ],
          ),
          ),
      ]),
        ],
    ),
    );
  
       
  }
}
