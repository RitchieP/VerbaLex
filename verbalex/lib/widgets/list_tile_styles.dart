import 'package:flutter/material.dart';

/// This function builds the big section divider in the settings screen.
/// It takes in a [title] parameter to define the section title.
Widget listTileTitle(String title, BuildContext context) {
  return ListTile(
    title: Text(title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
    ),
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
Widget listTileOptions(String title, String subtitle, bool isSwitch, BuildContext context,  {VoidCallback? onPressedFunction}) {
  return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      trailing: isSwitch
          ? Switch(value: false, onChanged: (bool value) {})
          : IconButton(
              // If there's a provided onPressed function, the button will execute
              // it. Otherwise, it will do nothing.
              onPressed: onPressedFunction ?? () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ));
}
