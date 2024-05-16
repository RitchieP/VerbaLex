import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:verbalex/utils/record_voice.dart';

class RecordButton extends StatefulWidget {
  const RecordButton(
      {super.key,
      required this.title,
      required this.onDataReturned,
      required this.onLoading});

  final String title;
  final Function onDataReturned;
  final String onPressedTitle = "Recording";
  final Function onLoading;

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
        widget.onLoading("Processing...");
        try {
          if (kDebugMode) print('Sending audio to server...');
          // final response = await (() => recorder.sendAudio(audioFile)).withRetries(5);
          final response = await r.retry(
            () {
              widget.onLoading("Transcribing...");
              return recorder.sendAudio(audioFile);
            },
            onRetry: (p0) => widget.onLoading("Loading model..."),
          );
          widget.onDataReturned(response.text);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }

          // If the request fails, we will return null to the output space.
          // Which later will be handled by the output space widget.
          widget.onDataReturned(null);
          if (kDebugMode) print(e.toString());
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
