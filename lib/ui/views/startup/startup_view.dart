import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => ViewModelBuilder<StartupViewModel>.reactive(
        builder: (context, model, child) => SafeArea(
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                Column()
              ],
            )
          )
        ),
        onModelReady: (model) => model.handleStartupLogic(),
        viewModelBuilder: () => StartupViewModel(),
      )
    );
  }
}