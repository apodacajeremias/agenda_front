import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  // final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      // this.color = blueGrey,
      this.isFilled = false,
      this.isTextWhite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(text),
        ));
  }
}
