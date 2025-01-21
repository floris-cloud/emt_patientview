
import 'package:fhir/r4/general_types/general_types.dart' as r4;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContactPointSystemExtension on r4.ContactPointSystem {


IconData getIconForContactPointSystem() {
    switch (this) {
      case r4.ContactPointSystem.phone:
        return Icons.phone;
      case r4.ContactPointSystem.email:
        return Icons.email;
      case r4.ContactPointSystem.fax:
        return Icons.print;
      case r4.ContactPointSystem.sms:
        return Icons.sms;
      default:
        return Icons.contact_page;
    }
  }
  String getName(context){
    switch(this){
      case r4.ContactPointSystem.phone:
        return AppLocalizations.of(context)!.phone;
      case r4.ContactPointSystem.email:
        return AppLocalizations.of(context)!.email;
      case r4.ContactPointSystem.fax:
        return AppLocalizations.of(context)!.fax;
      case r4.ContactPointSystem.sms:
        return AppLocalizations.of(context)!.sms;
      default:
        return AppLocalizations.of(context)!.other;
    }
  }
}