// Flutter imports:
import 'package:flutter/material.dart';

/// The class MainTittle is a [StatelessWidget] used to display the main tittle in the app
/// * Attributes:
/// - text
class MainTitle extends StatelessWidget {
  /// Text to be displayed
  final String text;
  /// Font color
  final Color color;
  /// Size of he font
  final double fontSize;
  /// alignement of the text in the tittle
  final TextAlign alignment;

  const MainTitle({Key? key,
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
