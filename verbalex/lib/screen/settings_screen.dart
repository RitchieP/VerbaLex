import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:verbalex/screen/pnc_screen.dart';
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
        appBar: const UpperNavBar(
          screen: "settings",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              listTileTitle("Preferences", context),
              listTileOptions(
                  "Dark Mode",
                  "By switching this, the screen will become white on black.",
                  true,
                  context),
              listTileOptions(
                  "Accent choice",
                  "Switch it to have the intelligent model best fit for you.",
                  false,
                  context,
                  onPressedFunction: () =>
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AccentSelection(),
                      ))),
              const SizedBox(
                height: 20,
              ),
              listTileTitle("Help", context),
              listTileOptions("Report a problem",
                  "Encountering something odd? Let us know!", false, context,
                  onPressedFunction: () => BetterFeedback.of(context)
                          .show((UserFeedback feedback) async {
                        final screenshotFilePath = await writeImageToStorage(feedback.screenshot);
                        final Email email = Email(
                          body: feedback.text,
                          subject: 'VerbaLex Feedback',
                          recipients: ['ritchiepoh@student.usm.my'],
                          attachmentPaths: [screenshotFilePath],
                        );
                        await FlutterEmailSender.send(email);
                      })),
              listTileOptions("Privacy and Security",
                  "Concerned about your privacy? Check this!", false, context,
                  onPressedFunction: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PnCScreen(),
                        ),
                      )
              ),
            ],
          ),
        ));
  }

  Future<String> writeImageToStorage(Uint8List feedbackScreenshot) async {
    final Directory output = await getTemporaryDirectory();
    final String screenshotFilePath = '${output.path}/feedback.png';
    final File screenshotFile = File(screenshotFilePath);
    await screenshotFile.writeAsBytes(feedbackScreenshot);
    return screenshotFilePath;
  }
}
