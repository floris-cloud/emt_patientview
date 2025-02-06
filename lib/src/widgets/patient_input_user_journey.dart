import 'package:flutter/material.dart';
import '../models/person.dart';
import '../models/triage_category.dart';
import '../repository/patient_repository.dart';

import '../models/patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../themes/app_color.dart';

class PatientInputUserJourney extends StatefulWidget {
  const PatientInputUserJourney({
    super.key,
  });

  @override
  PatientInputUserJourneyState createState() => PatientInputUserJourneyState();
}

class PatientInputUserJourneyState extends State<PatientInputUserJourney> {
  final preNameController = TextEditingController();
  final surNameController = TextEditingController();
  final ageController = TextEditingController();
  final birthDateController = TextEditingController();
  Gender gender = Gender.male;
  TriageCategory _triageCategory = TriageCategory.veryUrgent;
  void _setGender(Gender selectedGender) {
    setState(() {
      gender = selectedGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: birthDateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.birthdate,
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: preNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.prename,
                  ),
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
                child: Row(
                  children: [
                    Expanded(
                      child:DropdownButtonFormField(
                        value: _triageCategory,
                        items: [
                          DropdownMenuItem(
                            value: TriageCategory.emergency,
                            child: Text(
                              AppLocalizations.of(context)!.emergency,
                              style: TextStyle(
                                backgroundColor: TriageCategory.emergency.getColor(),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: TriageCategory.veryUrgent,
                            child: Text(
                              AppLocalizations.of(context)!.veryUrgent,
                              style: TextStyle(
                                backgroundColor: TriageCategory.veryUrgent.getColor(),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: TriageCategory.urgent,
                            child: Text(
                              AppLocalizations.of(context)!.urgent,
                              style: TextStyle(
                                backgroundColor: TriageCategory.urgent.getColor(),
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: TriageCategory.normal,
                            child: Text(
                              AppLocalizations.of(context)!.normal,
                              style: TextStyle(
                                backgroundColor: TriageCategory.normal.getColor(),
                                ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: TriageCategory.noUrgent,
                            child: Text(
                              AppLocalizations.of(context)!.noUrgent,
                              style: TextStyle(
                                backgroundColor: TriageCategory.noUrgent.getColor(),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          _triageCategory = value!;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => _setGender(Gender.male),
                      icon: Icon(Icons.male,
                      color: gender == Gender.male
                          ? AppColor.genderMale
                          : AppColor.notSelected,),
                    ),
                    IconButton(
                      onPressed: () => _setGender(Gender.female),
                      icon: Icon(Icons.female,
                      color: gender == Gender.female
                          ? AppColor.genderFemale
                          : AppColor.notSelected,),
                    ),
                    IconButton(
                      onPressed: () => _setGender(Gender.other),
                      icon: Icon(Icons.transgender,
                      color: gender == Gender.other
                          ? AppColor.genderOther
                          : AppColor.notSelected,),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: surNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.surname,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(flex: 2),
        const Spacer(flex: 2),
        const Spacer(flex: 2),
        ElevatedButton(
          autofocus: false,
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(
              Size(
                0.2 * MediaQuery.of(context).size.width,
                0.1 * MediaQuery.of(context).size.height,
              ),
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Text(AppLocalizations.of(context)!.addPatient),
          onPressed: () async {
            Patient patient = Patient(
              surName: surNameController.text,
              preName: preNameController.text,
              birthDate:
                  DateTime.tryParse(birthDateController.text) ?? DateTime.now(),
              gender: Gender.male,
              triageCategory: _triageCategory,
            );
            PatientStorage.savePatient(patient);
            const Spacer(flex: 1);
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        birthDateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
}
