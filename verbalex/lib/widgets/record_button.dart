import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:verbalex/utils/record_voice.dart';

class RecordButton extends StatefulWidget {
  const RecordButton(
      {super.key, required this.title, required this.onRecordButtonReleased});

  final String title;
  final Function onRecordButtonReleased;
  final String onPressedTitle = "Recording";

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
    const r = RetryOptions(maxAttempts: 5, delayFactor: Duration(seconds: 2));
    const snackBar = SnackBar(content: Text('Processing recording'));
    /**
     * Listener to record voice when the button is pressed.
     * The button will return to its initial state after the user
     * has released their finger from the button.
     */
    return Listener(
      onPointerDown: (event) {
        setState(() => isPressed = true);
        recorder.record();
      },
      onPointerUp: (event) async {
        setState(() => isPressed = false);
        final audioFile = await recorder.stop();
        try {
          print('Sending audio to server...');
          // final response = await (() => recorder.sendAudio(audioFile)).withRetries(5);
          final response = await r.retry(
            () => recorder.sendAudio(audioFile),
            onRetry: (p0) => print('Retrying...'),
          );
          widget.onRecordButtonReleased(response.text);
          if (context.mounted)
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(e.toString())));
          }
        }
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
            isPressed ? "Recording" : widget.title,
            style: const TextStyle(
                fontSize: 40, fontWeight: FontWeight.w700, color: Colors.white),
          )),
    );
  }
}
