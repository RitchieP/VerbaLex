import 'package:flutter/material.dart';

class UpperNavBar extends StatelessWidget implements PreferredSizeWidget {
  const UpperNavBar({super.key});

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
      actions: [
        IconButton(
          onPressed: () {

          },
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
