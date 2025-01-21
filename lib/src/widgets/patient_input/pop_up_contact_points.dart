import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:fhir/r4.dart' as r4;
import '../../models/patient.dart';
import '../../models/contact_points.dart';

class PopUpContactPoints extends StatefulWidget {
  final Patient patient;
  final Function(List<r4.ContactPoint>) onContactPointsUpdated;

  const PopUpContactPoints({Key? key, required this.patient, required this.onContactPointsUpdated}) : super(key: key);

  @override
  _PopUpContactPointsState createState() => _PopUpContactPointsState();
}

class _PopUpContactPointsState extends State<PopUpContactPoints> {
  List<r4.ContactPoint> _contactPoints = [];
  final _formKey = GlobalKey<FormState>();
  List<r4.ContactPointSystem> _contactPointsSystem = [r4.ContactPointSystem.phone, r4.ContactPointSystem.email, r4.ContactPointSystem.fax, r4.ContactPointSystem.other];
  @override
  void initState() {
    super.initState();
    _contactPoints = List.from(widget.patient.contactPoints);
  }

  void _addContactPoint() {
    setState(() {
      _contactPoints.add(r4.ContactPoint());
    });
  }

  void _removeContactPoint(int index) {
    setState(() {
      _contactPoints.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Kontaktpunkte bearbeiten'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ..._contactPointsSystem.asMap().entries.map((entry)
             {
                int index = entry.key;
                r4.ContactPoint? cp = _contactPoints.firstWhereOrNull((cp) => cp.system == entry.value);
                return Column(
                  key: ValueKey(index),
                  children: [
                    Row(
                      children: [
                        Icon(entry.value.getIconForContactPointSystem()),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            initialValue:cp?.value ?? '',
                            decoration: InputDecoration(labelText: entry.value.getName(context)),
                            onChanged: (value) {
                              setState(() {
                                _contactPoints[index] = r4.ContactPoint(system: entry.value, value: value);
                              });
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _removeContactPoint(index),
                        ),
                      ],
                    ),
                 
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addContactPoint,
                child: Text('Kontaktpunkt hinzufügen'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Abbrechen'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Speichern'),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onContactPointsUpdated(_contactPoints);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  
}

