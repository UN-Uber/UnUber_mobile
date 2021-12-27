// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class CustomDivider extends StatelessWidget {
  final String text;

  const CustomDivider({Key? key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(children: <Widget>[
          SizedBox(width: 20),
          _customExpanded(),
          Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) => this.text.isNotEmpty,
              widgetBuilder: (BuildContext context) => Text(this.text),
              fallbackBuilder: (BuildContext context) => SizedBox.shrink()),
          _customExpanded(),
          SizedBox(width: 20)
        ]));
  }

  Widget _customExpanded() {
    return Expanded(
        child: Padding(
            padding: this.text.isNotEmpty
                ? EdgeInsets.symmetric(horizontal: 10)
                : EdgeInsets.zero,
            child: Divider(thickness: 1)));
  }
}
