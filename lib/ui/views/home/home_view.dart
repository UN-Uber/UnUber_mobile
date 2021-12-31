// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/home/home_viewmodel.dart';

/// The class HomeView is the view for the home route
class HomeView extends StatelessWidget {
  const HomeView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, HomeViewModel model, child) => SafeArea(
        child: Scaffold(
          body: Container(),
        ),
      ),
      viewModelBuilder: () => HomeViewModel()
    );
  }
}
