// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/user/user_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/organisms/navigation_drawer/navigation_drawer_view.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;
import 'package:unuber_mobile/ui/widgets/atoms/bezier_container.dart';
import 'package:unuber_mobile/ui/widgets/atoms/loading_indicator.dart';

/// The class HomeView is the view for the home route
class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        builder: (context, UserViewModel model, child) => SafeArea(
              child: Scaffold(
                key: model.scaffoldKey,
                drawer: NavigationDrawerView(),
                appBar: AppBar(
                    leading: GestureDetector(
                        onTap: () =>
                            model.scaffoldKey.currentState?.openDrawer(),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8)),
                                color: appColors.primary),
                            child: Icon(Icons.menu_rounded))),
                    titleSpacing: 0,
                    backgroundColor: Colors.transparent,
                    elevation: 0),
                body: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -(_screenSize.height * .225),
                      right: -(_screenSize.width * .4),
                      child: BezierContainer(),
                    ),
                    Column(
                      children: <Widget>[],
                    )
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => UserViewModel());
  }
}
