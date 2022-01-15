// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/set_points/set_points_viewmodel.dart';

/// The class SetPointsView is the view for the Set Points route
class SetPointsView extends StatelessWidget {
  const SetPointsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, SetPointsViewModel model, child) => SafeArea(child: Scaffold(
        body: Container()
      )),
      viewModelBuilder: () => SetPointsViewModel(),
    );
  }
}
