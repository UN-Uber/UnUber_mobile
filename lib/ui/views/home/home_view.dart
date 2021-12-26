import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unuber_mobile/ui/views/home/home_viewmodel.dart';

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
