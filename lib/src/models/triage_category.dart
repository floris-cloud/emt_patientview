import 'package:flutter/material.dart';
import '../themes/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fhir/r4.dart' as r4;

import 'patient.dart';
 enum TriageCategory {
  emergency,
  veryUrgent,
  urgent,
  normal,
  noUrgent,
}
extension TriageCategoryExtension on TriageCategory {

  r4.Observation getFhirTriage(Patient p)
  {
    switch(this){
      case TriageCategory.emergency:
      {
        return r4.Observation(
          status: r4.FhirCode('final'),
          code: 
            r4.CodeableConcept(
              coding: [
                r4.Coding(
                  code: r4.FhirCode('MTS-1'),
                )
              ]
            ),
          subject: r4.Reference(
            reference: 'Patient/${p.id}'
          ),
          effectiveDateTime: r4.FhirDateTime(p.firstContact),
          );
}  
      case TriageCategory.veryUrgent:
      {
       return r4.Observation(
          status: r4.FhirCode('final'),
          code: 
            r4.CodeableConcept(
              coding: [
                r4.Coding(
                  code: r4.FhirCode('MTS-2'),
                )
              ]
            ),
          subject: r4.Reference(
            reference: 'Patient/${p.id}'
          ),
          effectiveDateTime: r4.FhirDateTime(p.firstContact),
          );}
          case TriageCategory.urgent:
          {
             return r4.Observation(
          status: r4.FhirCode('final'),
          code: 
            r4.CodeableConcept(
              coding: [
                r4.Coding(
                  code: r4.FhirCode('MTS-3'),
                )
              ]
            ),
          subject: r4.Reference(
            reference: 'Patient/${p.id}'
          ),
          effectiveDateTime: r4.FhirDateTime(p.firstContact),
          );
          }
          case TriageCategory.normal:
          
          {

          return r4.Observation(
          status: r4.FhirCode('final'),
          code: 
            r4.CodeableConcept(
              coding: [
                r4.Coding(
                  code: r4.FhirCode('MTS-4'),
                )
              ]
            ),
          subject: r4.Reference(
            reference: 'Patient/${p.id}'
          ),
          effectiveDateTime: r4.FhirDateTime(p.firstContact),
          );
    }
    case TriageCategory.noUrgent:
   {

     return r4.Observation(
          status: r4.FhirCode('final'),
          code: 
            r4.CodeableConcept(
              coding: [
                r4.Coding(
                  code: r4.FhirCode('MTS-5'),
                )
              ]
            ),
          subject: r4.Reference(
            reference: 'Patient/${p.id}'
          ),
          effectiveDateTime: r4.FhirDateTime(p.firstContact),
          );
    }
    }
  }

  Duration getDuration() {
    switch (this) {
      case TriageCategory.emergency:
        return const Duration(seconds: 0);
      case TriageCategory.veryUrgent:
        return const Duration(seconds: 20);
      case TriageCategory.urgent:
        return const Duration(minutes: 30);
      case TriageCategory.normal:
        return const Duration(minutes: 90);
      case TriageCategory.noUrgent:
        return const Duration(hours: 2); //
      default:
        return const Duration(seconds: 0);
    }
  }

   Color getColor() {
    switch (this) {
      case TriageCategory.emergency:
        return AppColor.triageCategoryRed;
      case TriageCategory.veryUrgent:
        return AppColor.triageCategoryOrange;
      case TriageCategory.urgent:
        return AppColor.triageCategoryYellow;
      case TriageCategory.normal:
        return AppColor.triageCategoryGreen;
      case TriageCategory.noUrgent:
        return AppColor.triageCategoryBlue;
      default:
        return AppColor.noTriageCategory;
    }
  }
  String getText(BuildContext context){  
  switch (this) {
      case TriageCategory.emergency:
        return AppLocalizations.of(context)!.emergency;
      case TriageCategory.veryUrgent:
        return AppLocalizations.of(context)!.veryUrgent;
      case TriageCategory.urgent:
        return AppLocalizations.of(context)!.urgent;
      case TriageCategory.normal:
        return AppLocalizations.of(context)!.normal;
      case TriageCategory.noUrgent:
        return AppLocalizations.of(context)!.noUrgent;
      default:
        return AppLocalizations.of(context)!.urgent;
    }
  }
}
