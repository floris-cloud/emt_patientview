import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings/settings_view.dart';
import 'add_patient_button.dart';
import '../settings/settings_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    final settingsController = Provider.of<SettingsController>(context);

    return AppBar(
      leading: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // do something
            },
          ),
          AddPatientButton(),
        ],
      ),
      leadingWidth: 112,
      title: Row(children: 
      [
        Text(title),
        Container(
          constraints: BoxConstraints(maxHeight: kToolbarHeight-8),
          child:
        Image(image: AssetImage('assets/images/johanniter_international_logo.png'), fit: BoxFit.fitHeight,)),
        ]),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsView(controller: settingsController),
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // do something
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}