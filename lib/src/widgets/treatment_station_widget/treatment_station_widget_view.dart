import 'package:flutter/material.dart';
import '../../models/treatment_station.dart';
import '../../models/patient.dart';

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
      width: 200,
      child: Column(
        children: [
          Container(
            color: widget.treatmentStation.color,
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${widget.treatmentStation.id} ${widget.treatmentStation.name}',
              textAlign: TextAlign.left,
            ),
          ),
          Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                color: widget.treatmentStation.patient?.triageCategory.getColor()?? Colors.grey[200],
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
                        // Handle edit button press
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        widget.treatmentStation.patient = null;
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Handle add button press
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
