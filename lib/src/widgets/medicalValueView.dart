import 'package:flutter/material.dart';

import '../models/medical_values.dart';

class Medicalvalueview extends StatelessWidget{
  MedicalValues medicalValue;
  Medicalvalueview({required this.medicalValue});
  @override
   Widget build(BuildContext context) {
    final Map<String, dynamic> medicalValueMap = medicalValue.toJson();
    medicalValueMap.remove('medicalValuesAdded');
    final filteredValues = medicalValueMap.entries.where((entry) => entry.value != null).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time added : ${medicalValue.createdAt.day.toString().padLeft(2, '0')}${medicalValue.createdAt.hour.toString().padLeft(2, '0')}${medicalValue.createdAt.minute.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...filteredValues.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Text(
                    ' ${entry.key}: ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${entry.value}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}