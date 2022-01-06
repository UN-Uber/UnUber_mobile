// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/utils/colors.dart' as appColors;

/// The class EntryField is a [StatelessWidget] used to customice a text field for multiple purposes
class EntryField extends StatelessWidget {
  /// Title for the component
  final String title;
  /// Message to disply when an error occurs
  final String? errorMessage;
  /// Hint for the user
  final String? hintText;
  /// Suffix text to place in the text field after user input
  final String? suffixText;
  /// Prefix text to place in the text field before user input
  final String? prefixText;
  /// Flag to censor the content of the text field
  final bool isPassword;
  /// Icon to place in the text field after user input
  final IconData? suffixIcon;
  /// Icon to place in the text field before user input
  final IconData? prefixIcon;
  /// Select the type of text to adapt the user keyboard correctly
  final TextInputType textType;
  /// Function to execute when the text field suffers a change
  final Function(String) onChange;

  const EntryField(
      {Key? key,
      required this.errorMessage,
      this.hintText,
      required this.title,
      this.suffixText,
      this.prefixText,
      this.isPassword = false,
      this.suffixIcon,
      this.prefixIcon,
      required this.textType,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: appColors.primaryVariant),
              ),
              TextField(
                  onChanged: this.onChange,
                  obscureText: this.isPassword,
                  keyboardType: this.textType,
                  decoration: InputDecoration(
                      errorText: this.errorMessage,
                      border: InputBorder.none,
                      fillColor: appColors.fillInput,
                      filled: true,
                      hintText: this.hintText,
                      suffixIcon: this.suffixIcon != null
                          ? Icon(this.suffixIcon)
                          : null,
                      prefixIcon: this.prefixIcon != null
                          ? Icon(this.prefixIcon)
                          : null,
                      suffixText: this.suffixText,
                      prefixText: this.prefixText))
            ]));
  }
}
