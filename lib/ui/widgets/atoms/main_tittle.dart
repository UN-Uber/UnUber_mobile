// Flutter imports:
import 'package:flutter/material.dart';

class MainTittle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign alignment;

  const MainTittle({Key? key,
      required this.text,
      required this.color,
      required this.fontSize,
      this.alignment = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: this.alignment,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: this.color,
        fontSize: this.fontSize
      )
    );
  }
}
