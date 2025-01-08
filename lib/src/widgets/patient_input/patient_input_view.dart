import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/person.dart';
import '../../themes/app_color.dart';
import 'patient_input_controller.dart';

class PatientInputView extends StatelessWidget {
  const PatientInputView({super.key});
 @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PatientInputController>(context);
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.birthDateController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.birthdate,
                  ),
                  readOnly: true,
                  onTap: () => controller.selectDate(context),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.preNameController,
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
                        value: controller.triageCategory,
                        items: [
                          DropdownMenuItem(
                            value: 0,
                            child: Text(
                              AppLocalizations.of(context)!.emergency,
                              style: TextStyle(
                                backgroundColor: AppColor.triageCategoryRed,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              AppLocalizations.of(context)!.veryUrgent,
                              style: TextStyle(
                                backgroundColor: AppColor.triageCategoryOrange,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              AppLocalizations.of(context)!.urgent,
                              style: TextStyle(
                                backgroundColor: AppColor.triageCategoryYellow,
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text(
                              AppLocalizations.of(context)!.normal,
                              style: TextStyle(
                                backgroundColor: AppColor.triageCategoryGreen,
                                ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text(
                              AppLocalizations.of(context)!.noUrgent,
                              style: TextStyle(
                                backgroundColor: AppColor.triageCategoryBlue,
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          controller.setTriageCategory(value!);
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.male,
                      color: controller.gender == Gender.male
                          ? AppColor.genderMale
                          : AppColor.notSelected,),
                      onPressed: () => controller.setGender(Gender.male),
                    ),
                    IconButton(
                      icon: Icon(Icons.female,
                      color: controller.gender == Gender.female
                          ? AppColor.genderFemale
                          : AppColor.notSelected,),
                    onPressed: () =>  controller.setGender(Gender.female),
                    ),
                    IconButton(
                      icon: Icon(Icons.transgender,
                      color: controller.gender == Gender.other
                          ? AppColor.genderOther
                          : AppColor.notSelected,),
                      onPressed: () => controller.setGender(Gender.other),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller.surNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.surname,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(flex: 4),
    
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
           controller.savePatient();
            const Spacer(flex: 1);
          },
        ),
      ],
    );
  }
}
