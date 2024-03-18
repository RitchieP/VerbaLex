import 'package:flutter/material.dart';
import 'package:verbalex/widgets/ListTileStyles.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(screen: "settings",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            listTileTitle("Preferences"),
            listTileOptions(
              "Dark Mode", 
              "By switching this, the screen will become white on black.", 
              true
            ),
            listTileOptions(
              "Accent choice", 
              "Switch it to have the intelligent model best fit for you.", 
              false
            ),
            const SizedBox(height: 20,),
            listTileTitle("Help"),
            listTileOptions(
              "Report a problem", 
              "Encountering something odd? Let us know!", 
              false
            ),
            listTileOptions(
              "Privacy and Security",
              "Concerned about your privacy? Check this!", 
              false
            )
          ],
        ),
      )
    );
  }
}