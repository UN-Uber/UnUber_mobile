// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/utils/colors.dart' as appColors;
import 'package:unuber_mobile/utils/constraints.dart' as constraints;

/// The class GoogleButton is a [StatelessWidget] used to display the google access button in the login route
class GoogleButton extends StatelessWidget {
  /// Function to execute when the button is pressed
  final VoidCallback onPressed;
  
  const GoogleButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: appColors.googleButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(constraints.btnRadius)
        ),
        padding: const EdgeInsets.all(0.0)
      ),
      onPressed: this.onPressed,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(1),
            child: Container(
              height: _screenSize.height * .075,
              width: _screenSize.width * .883,
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(constraints.btnRadius)
              ),
              child: Center(
                child: Image(
                  image: AssetImage('graphics/google-logo.png',
                  package: 'flutter_auth_buttons'),
                  height: 25.0,
                  width: 25.0
                )
              )
            )
          )
        ],
      )
    );
  }
}
