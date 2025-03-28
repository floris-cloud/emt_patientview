import 'package:emt_patientview/src/models/triage_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';
import '../../models/patient_list.dart';
import '../../models/person.dart';
import '../../themes/app_color.dart';

import 'patient_input_controller.dart';

class PatientInputView extends StatelessWidget {
  const PatientInputView({super.key});
  final double max = 600;
  final double min = 200;

 @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PatientInputController>(context);
    return
    Column(
      children: <Widget>[
     Wrap(
      spacing: 10,
      runSpacing: 5,
      children: <Widget>[
     Container(
              constraints: BoxConstraints(
                minWidth: min,
                maxWidth: max
              ),
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
          
     Container(
              constraints: BoxConstraints(
                minWidth: min,
                maxWidth: max
              ),
  
                child: TextField(
                  controller: controller.preNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.prename,
                  ),
                ),
              ),
                             Container(
              constraints: BoxConstraints(
                minWidth: min,
                maxWidth: max
              ),
              child: 
                  TextField(
                  controller: controller.surNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.surname,
                  ),
                ),),

            Container(
              constraints: BoxConstraints(
                minWidth: min,
                maxWidth: max
              ),
              child:            
                        DropdownButtonFormField(
                    
                        value: controller.triageCategory,
                        items: [
                         ...TriageCategory.values.map((category) {
  return DropdownMenuItem(
    value: category,
    child: Text(
      category.name, 
      style: TextStyle(
        backgroundColor: category.getColor(),
      ),
    ),
  );
})],
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
            Provider.of<PatientListModel>(context, listen: false)
                .add(controller.createPatient());
          //  controller.savePatient();
            const Spacer(flex: 1);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
