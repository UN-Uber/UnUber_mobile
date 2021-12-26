// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/atoms/custom_clipper.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        child: Transform.rotate(
            angle: -(pi / 3.5),
            child: ClipPath(
                clipper: ClipPainter(),
                child: Container(
                    height: _screenSize.height * .45,
                    width: _screenSize.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          appColors.secondary,
                          appColors.primary
                        ]))))));
  }
}
