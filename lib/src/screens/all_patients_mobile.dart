import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/appBar.dart';

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