import 'package:flutter/material.dart';

import '../screen/settings_screen.dart';

class UpperNavBar extends StatelessWidget implements PreferredSizeWidget {
  const UpperNavBar({super.key, required this.screen});

  /// Only accepts "homepage" or "settings" as a value
  final String screen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('VerbaLex'),
      backgroundColor: Theme.of(context).backgroundColor,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 32,
      ),
      centerTitle: true,
      elevation: 0,
      leading: screen == "settings"
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 30,
              ),
            )
          : null,
      actions: screen == "homepage"
          ? [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}