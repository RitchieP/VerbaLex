import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  const CustomTextButton({super.key, required this.title, this.onPressedTitle});

  final String title;
  final String? onPressedTitle;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  late Color onPressedColor;
  late Color onReleasedColor;
  late bool isPressed;

  @override
  void initState() {
    super.initState();
    isPressed = false;
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
      onPointerDown: (event) => setState(() => isPressed = true),
      onPointerUp: (event) => setState(() => isPressed = false),
      child: TextButton(
          onPressed: () {
          },
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
