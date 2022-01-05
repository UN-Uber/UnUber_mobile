// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class SingleMessageDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const SingleMessageDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
    color: Colors.white,
      ),
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        request.title!,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
      SizedBox(height: 10),
      Text(
        request.description!,
        style: TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20),
      GestureDetector(
        onTap: () => completer(DialogResponse(confirmed: true)),
        child: Container(
          child: request.showIconInSecondaryButton!
              ? Icon(Icons.check_circle)
              : Text(
                  request.mainButtonTitle!,
                  style: TextStyle(color: appColors.white),
                ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: appColors.googleButton,
              borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    ],
      ),
    );
  }
}
