// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/utils/colors.dart' as appColors;

/// The class BackButton is a [StatelessWidget] used to pop the first route in the routes stack
/// and return to the last route
class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                    child:
                        Icon(Icons.arrow_back_ios, color: appColors.primary)),
                Text('Atras',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: appColors.primary))
              ],
            )));
  }
}
