import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/treatment_station.dart';
import '../models/treatment_station_list.dart';
import '../repository/treatment_station_repository.dart';

class AddTreatmentStationDialog extends StatefulWidget {
  @override
  _AddTreatmentStationDialogState createState() => _AddTreatmentStationDialogState();
}

class _AddTreatmentStationDialogState extends State<AddTreatmentStationDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int? _id = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Treatment Station'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(            
                
                decoration: InputDecoration(labelText: _id.toString()),
                onChanged: (value) {
         
                setState(() {
                  _id = (int.tryParse(value));
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a id';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              TreatmentStation ts = TreatmentStation(id: _id!, name: _name);
              Provider.of<TreatmentStationList>(context, listen: false).addTreatmentStation(
                ts
              );
              TreatmentStationRepository().postTreatmentStation(ts);
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}