import 'package:flutter/material.dart';

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
            shadows: [Shadow(color: Colors.black, offset: Offset(0, -5))])),
  );
}

Widget listTileOptions(String title, String subtitle, bool isSwitch) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
    ),
    subtitle: Text(subtitle, style: const TextStyle(color: Colors.black),),
    trailing: isSwitch
        ? Switch(value: false, onChanged: (bool value) {})
        : IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.arrow_forward_ios, color: Colors.black,),
        )
  );
}
