import 'package:flutter/material.dart';
import '../themes/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TriageCategory {
  final int triageCategory;

  const TriageCategory(this.triageCategory);

  Duration getDuration() {
    switch (triageCategory) {
      case 0:
        return const Duration(seconds: 0);
      case 1:
        return const Duration(seconds: 20);
      case 2:
        return const Duration(minutes: 30);
      case 3:
        return const Duration(minutes: 90);
      case 4:
        return const Duration(hours: 2); //
      default:
        return const Duration(seconds: 0);
    }
  }

   Color getColor() {
    switch (triageCategory) {
      case 0:
        return AppColor.triageCategoryRed;
      case 1:
        return AppColor.triageCategoryOrange;
      case 2:
        return AppColor.triageCategoryYellow;
      case 3:
        return AppColor.triageCategoryGreen;
      case 4:
        return AppColor.triageCategoryBlue;
      default:
        return AppColor.noTriageCategory;
    }
  }
  String getText(BuildContext context){
    // return("TODO");  
  switch (triageCategory) {
      case 0:
        return AppLocalizations.of(context)!.emergency;
      case 1:
        return AppLocalizations.of(context)!.veryUrgent;
      case 2:
        return AppLocalizations.of(context)!.urgent;
      case 3:
        return AppLocalizations.of(context)!.normal;
      case 4:
        return AppLocalizations.of(context)!.noUrgent;
      default:
        return AppLocalizations.of(context)!.urgent;
    }
  }
}
