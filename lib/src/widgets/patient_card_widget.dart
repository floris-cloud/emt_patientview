import 'package:emt_patientview/src/widgets/timer.dart';
import 'package:flutter/material.dart';
import '../models/protocol.dart';
import '../models/triage_category.dart';
import '../screens/protocol_entry_screen.dart';
import '../models/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;

  const PatientCard({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      color: Theme.of(context).secondaryHeaderColor,
      height: 86.0,
      constraints: BoxConstraints(maxWidth: 500),
      child:
    Stack(
      children: [
        //Hintergrund
        Align(
          alignment: Alignment.centerRight,
          child:
         FractionallySizedBox(
            widthFactor: 0.2,
            heightFactor: 1.0,
            child: Container(
              color: patient.triageCategory.getColor(),
            ),
           ),
        ),
        Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text(
                    patient.id.split('-').first,
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    patient.surName+", "+patient.preName,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Row(children: [
                    
                  Text(
                    patient.formatedBirthDate(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[700],
                    ),
                  ),Icon(patient.gender.icon, color: Colors.black,),
                  SizedBox(height: 4.0),
                  Text(
                    patient.diagnose ?? " ",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  ],)
                ],
              ),
          TimerWidget(patient: patient),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.grey[600]),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProtocolEntryScreen(patient: patient),
                ),
              );
            },
          ),
        ],
      ),
    ),
      ],
    ),
    );
      
  }

 
}