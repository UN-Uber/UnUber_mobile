// Flutter imports:
import 'package:flutter/material.dart';

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
