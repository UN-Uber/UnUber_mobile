// Flutter imports:
import 'package:flutter/material.dart';

/// The class LoafingIndicator is a [StatelessWidget] used to generate a ciruclar loading indicator where needed
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator()
        )
      )
    );
  }
}
