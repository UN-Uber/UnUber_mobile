// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/utils/colors.dart' as appColors;
import 'package:unuber_mobile/utils/constraints.dart' as constraints;

/// The class SubmitButton is a [StatelessWidget] used to place a button for a form to select when no more changes are going to be done
class SubmitButton extends StatelessWidget {
  /// Text of the button
  final String text;
  /// Function to be executed when the button is pressed
  final VoidCallback onPressed;

  const SubmitButton({ Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(constraints.btnRadius)
        ),
        padding: const EdgeInsets.all(0.0)
      ),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              appColors.secondary,
              appColors.primary
            ]
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(constraints.btnRadius)
          )
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: _screenSize.height * .075
          ),
          alignment: Alignment.center,
          child: Text(
            this.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: constraints.btnFontSize
            )
          )
        )
      )
    );
  }
}
