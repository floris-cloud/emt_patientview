import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/patient_list.dart';
import '../models/person.dart';
import '../models/triage_category.dart';
import '../repository/patient_repository.dart';

import '../models/patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../themes/app_color.dart';

class PatientChangeUserJourney extends StatefulWidget {
  final Patient patient;
  const PatientChangeUserJourney({super.key, required this.patient});

  @override
  _PatientChangeUserJourneyState createState()
      => _PatientChangeUserJourneyState();
}

class _PatientChangeUserJourneyState extends State<PatientChangeUserJourney> {
  final preNameController = TextEditingController();
  final surNameController = TextEditingController();
  final birthDateController = TextEditingController();
  late Gender gender;
  late TriageCategory _triageCategory;
  @override
  void initState() {
    super.initState();
    _setGender(widget.patient.gender);
    preNameController.text = widget.patient.preName;
    surNameController.text = widget.patient.surName;
    birthDateController.text =
        widget.patient.birthDate.toLocal().toString().split(' ')[0];
    _triageCategory = widget.patient.triageCategory;
  }

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
                          labelText: DateFormat.yMd(
                                  AppLocalizations.of(context)!.localeName,)
                              .format(widget.patient.birthDate),
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
                          labelText: widget.patient.preName,
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
                            child: DropdownButtonFormField(
                              value: _triageCategory,
                              items: [
                                DropdownMenuItem(
                                    value: TriageCategory.emergency,
                                    child: Text(
                                      AppLocalizations.of(context)!.emergency,
                                      style: TextStyle(
                                          backgroundColor:
                                              TriageCategory.emergency.getColor(),),
                                    ),),
                                DropdownMenuItem(
                                    value: TriageCategory.veryUrgent,
                                    child: Text(
                                      AppLocalizations.of(context)!.veryUrgent,
                                      style: TextStyle(
                                          backgroundColor:
                                              TriageCategory.veryUrgent.getColor(),),
                                    ),),
                                DropdownMenuItem(
                                    value: TriageCategory.urgent,
                                    child: Text(
                                      AppLocalizations.of(context)!.urgent,
                                      style: TextStyle(
                                          backgroundColor:
                                              TriageCategory.veryUrgent.getColor(),),
                                    ),),
                                DropdownMenuItem(
                                    value: TriageCategory.normal,
                                    child: Text(
                                      AppLocalizations.of(context)!.normal,
                                      style: TextStyle(
                                          backgroundColor:
                                              TriageCategory.normal.getColor(),),
                                    ),),
                                DropdownMenuItem(
                                    value: TriageCategory.noUrgent,
                                    child: Text(
                                      AppLocalizations.of(context)!.noUrgent,
                                      style: TextStyle(
                                          backgroundColor:
                                              TriageCategory.noUrgent.getColor(),),
                                    ),),
                              ],
                              onChanged: (value) {
                                _triageCategory = value!;
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () => _setGender(Gender.male),
                            icon: Icon(
                              Icons.male,
                              color: gender == Gender.male
                                  ? AppColor.genderMale
                                  : AppColor.notSelected,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _setGender(Gender.female),
                            icon: Icon(
                              Icons.female,
                              color: gender == Gender.female
                                  ? AppColor.genderFemale
                                  : AppColor.notSelected,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _setGender(Gender.other),
                            icon: Icon(
                              Icons.transgender,
                              color: gender == Gender.other
                                  ? AppColor.genderOther
                                  : AppColor.notSelected,
                            ),
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
                          labelText: widget.patient.surName,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                autofocus: false,                              
                clipBehavior: Clip.hardEdge,
                child: Text(AppLocalizations.of(context)!.changePatient),
                onPressed: () async {
                  widget.patient.preName = preNameController.text;
                  widget.patient.surName = surNameController.text;
                  widget.patient.birthDate =
                      DateTime.parse(birthDateController.text);
                  widget.patient.gender = gender;
                  widget.patient.triageCategory = _triageCategory;

                PatientStorage.changePatient(widget.patient);
                Provider.of<PatientListModel>(context, listen: false)
                .change(widget.patient);
                },
                
            ),
          ],
        );
     
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        birthDateController.text
            = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }
}
