import 'dart:io';

import 'package:flutter/material.dart';
import 'package:verbalex/utils/record_voice.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({super.key, required this.title, this.onPressedTitle});

  final String title;
  final String? onPressedTitle;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  late Color onPressedColor;
  late Color onReleasedColor;
  late bool isPressed;

  final recorder = Recorder();

  @override
  void initState() {
    super.initState();
    recorder.initRecorder();
    isPressed = false;
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onPressedColor = Theme.of(context).focusColor;
    onReleasedColor = Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Listener to allow the button to change color and text on when the button
     * is pressed. The button will return to its initial state after the user
     * has released their finger from the button.
     */
    return Listener(
      onPointerDown: (event) {
        setState(() => isPressed = true);
        recorder.record();
      },
      onPointerUp: (event) async {
        setState(() => isPressed = false);
        File audioFilePath = await recorder.stop();
        recorder.playAudio(audioFilePath);
      },
      child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(onReleasedColor),
            overlayColor: MaterialStateProperty.all<Color>(onPressedColor),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            splashFactory: NoSplash.splashFactory,
            animationDuration: Duration.zero,
          ),
          child: Text(
            isPressed ? widget.onPressedTitle ?? widget.title : widget.title,
            style: const TextStyle(
                fontSize: 40, fontWeight: FontWeight.w700, color: Colors.white),
          )),
    );
  }
}