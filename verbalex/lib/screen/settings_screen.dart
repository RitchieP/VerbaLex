import 'package:flutter/material.dart';
import 'package:verbalex/widgets/list_tile_styles.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

import 'accent_selection.dart';

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
            listTileTitle("Preferences", context),
            listTileOptions(
              "Dark Mode", 
              "By switching this, the screen will become white on black.", 
              true,
              context
            ),
            listTileOptions(
              "Accent choice", 
              "Switch it to have the intelligent model best fit for you.", 
              false,
              context,
              onPressedFunction: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AccentSelection(),
                )
              )
            ),
            const SizedBox(height: 20,),
            listTileTitle("Help", context),
            listTileOptions(
              "Report a problem", 
              "Encountering something odd? Let us know!", 
              false,
              context
            ),
            listTileOptions(
              "Privacy and Security",
              "Concerned about your privacy? Check this!", 
              false,
              context
            )
          ],
        ),
      )
    );
  }
}