import 'package:emt_patientview/src/widgets/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/treatment_station_list.dart';
import '../../models/triage_category.dart';
import '../../models/treatment_station.dart';
import '../../models/patient.dart';


import '../../screens/protocol_entry_screen.dart';
import '../pop_up_change_patient.dart';
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
                        if(widget.treatmentStation.patient != null){           
                         Provider.of<TreatmentStationList>(context, listen: false).setShowPatient(widget.treatmentStation.patient!);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                            if(widget.treatmentStation.patient != null) {
             
                                    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProtocolEntryScreen(patient: widget.treatmentStation.patient!),
                ),
              );
                            }
                      },
                     ),
                    
               
            
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                       color: widget.treatmentStation.patient != null ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                      onPressed: () {
                        widget.treatmentStation.patient!.patTreatmentStationId = null;
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
              widget.treatmentStation.patient != null
                  ? Column(
                      children: [
                        Text(
                          (widget.treatmentStation.patient?.surName ?? "") + ", " + (widget.treatmentStation.patient?.preName ?? ""),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.treatmentStation.patient?.formatedBirthDate() ?? "",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            Icon(widget.treatmentStation.patient?.gender.icon),
                            // Text(
                            //   widget.treatmentStation.patient?.diagnose ?? " ",
                            //   style: TextStyle(
                            //     fontSize: 14.0,
                            //     fontWeight: FontWeight.w500,
                            //     color: Colors.grey[800],
                            //   ),
                            // ),
                          ],
                        ),
                        TimerWidget(startTime: widget.treatmentStation.patient!.firstContact),
                        // Text(
                        //   AppLocalizations.of(context)!.diagnose + (widget.treatmentStation.patient?.diagnose ?? " ")
                        //   ),
                        
                                          ],
                    )
                  : Container(
                      child: Text(
                        AppLocalizations.of(context)!.dragPatientHere,
                        style: TextStyle(color: Colors.grey),
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
