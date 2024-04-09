import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:verbalex/utils/accents.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

class AccentSelection extends StatelessWidget {
  const AccentSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const UpperNavBar(screen: "settings"),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: ACCENTS.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: Flag.fromString(
                  ACCENT_CODES[ACCENTS[index]].toString(), 
                  height: 25
                ),
              ),
              title: Text(
                ACCENTS[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                )
              ),
              onTap: () {
                
              },
            );
          },
        ));
  }
}
