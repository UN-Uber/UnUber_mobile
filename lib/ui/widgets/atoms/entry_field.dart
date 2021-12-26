// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class EntryField extends StatelessWidget {
  final String tittle;
  final String? errorMessage;
  final String? suffixText;
  final bool isPassword;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType textType;
  final Function(String) onChange;

  const EntryField(
      {Key? key,
      required this.errorMessage,
      required this.tittle,
      this.suffixText,
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
                tittle,
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
                      suffixIcon: this.suffixIcon != null
                          ? Icon(this.suffixIcon)
                          : null,
                      prefixIcon: this.prefixIcon != null
                          ? Icon(this.prefixIcon)
                          : null,
                      suffixText: this.suffixText))
            ]));
  }
}
