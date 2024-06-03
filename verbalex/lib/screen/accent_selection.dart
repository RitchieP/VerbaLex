import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verbalex/utils/accents.dart';
import 'package:verbalex/widgets/upper_nav_bar.dart';

class AccentSelection extends StatefulWidget {
  const AccentSelection({super.key});

  @override
  State<AccentSelection> createState() => _AccentSelectionState();
}

class _AccentSelectionState extends State<AccentSelection> {
  int? accentIndex;

  Future getAccentIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accent = prefs.getString('accent') ?? "Arabic";
    return ACCENTS.indexOf(accent);
  }

  Future changeAccent(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Change the checkmark to the new accent.
    setState(() {
      accentIndex = index;
    });
    await prefs.setString('accent', ACCENTS[index]);
  }

  @override
  void initState() {
    super.initState();
    getAccentIndex().then((value) {
      setState(() {
        accentIndex = value;
      });
    });
  }
  
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
                decoration: const BoxDecoration(
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
              onTap: () async {
                await changeAccent(index);
              },
              trailing: Visibility(
                visible: index == accentIndex,
                child: const Icon(Icons.check),
              )
            );
          },
        ));
  }
}
