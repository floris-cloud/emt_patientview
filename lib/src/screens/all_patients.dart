import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'all_patients_desktop.dart';
import 'all_patients_mobile.dart';



class AllPatScreen extends StatelessWidget {
  const AllPatScreen({super.key});
   @override
  Widget build(BuildContext context) {
 bool isDesktop = kIsWeb && MediaQuery.of(context).size.width > 1000;
return isDesktop ? AllPatDeskScreen() : AllPatMobileScreen();
}
}