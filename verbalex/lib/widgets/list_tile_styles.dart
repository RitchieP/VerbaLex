import 'package:flutter/material.dart';

/// This function builds the big section divider in the settings screen.
/// It takes in a [title] parameter to define the section title.
Widget listTileTitle(String title) {
  return ListTile(
    title: Text(title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.transparent,
            decorationColor: Colors.black,
            // This shadow configuration is to configure the amount of spacing 
            // between the underline and the text.
            shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))])),
  );
}

/// This function builds the various options that will be displayed in the 
/// settings screen.
/// 
/// [title] is the title of the option.
/// 
/// [subtitle] is the description of the option.
/// 
/// [isSwitch] is a boolean that determines if the setting's tile have a switch button or not.
/// 
/// [onPressedFunction] is a function that will be executed when the tile is pressed.
Widget listTileOptions(String title, String subtitle, bool isSwitch, {VoidCallback? onPressedFunction}) {
  return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: isSwitch
          ? Switch(value: false, onChanged: (bool value) {})
          : IconButton(
              // If there's a provided onPressed function, the button will execute
              // it. Otherwise, it will do nothing.
              onPressed: onPressedFunction ?? () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
            ));
}
