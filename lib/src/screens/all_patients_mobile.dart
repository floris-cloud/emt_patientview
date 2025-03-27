import 'package:flutter/material.dart';
import 'package:emt_patientview/l10n/generated/app_localizations.dart';

import '../widgets/app_bar.dart';

class AllPatMobileScreen extends StatefulWidget {
  const AllPatMobileScreen({super.key});

  @override
  State<AllPatMobileScreen> createState() => _AllPatMobileScreenState();
}
class _AllPatMobileScreenState extends State<AllPatMobileScreen> {


  @override

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.allPatients),
      body:   Text("Mobile"),
    );
  }
}