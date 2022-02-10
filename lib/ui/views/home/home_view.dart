// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/home/home_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/custom_divider.dart';
import 'package:unuber_mobile/ui/widgets/organisms/navigation_drawer/navigation_drawer_view.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

/// The class HomeView is the view for the home route
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, HomeViewModel model, child) => SafeArea(
              child: Scaffold(
                key: model.scaffoldKey,
                drawer: NavigationDrawerView(
                  accountTap: () {},
                ),
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
                body: Column(children: <Widget>[
                  SizedBox(height: 30),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 80,
                      decoration: BoxDecoration(
                          color: appColors.primary,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: GestureDetector(
                        onTap: model.navigateToSetPoints,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.directions_car_rounded,
                                  color: appColors.secondary, size: 60),
                              Text('Iniciar un nuevo viaje!',
                                  style: TextStyle(
                                      color: appColors.secondary, fontSize: 25))
                            ]),
                      )),
                  SizedBox(height: 25),
                  CustomDivider(text: 'Destinos favoritos'),
                  SizedBox(height: 25)
                ]),
              ),
            ),
        viewModelBuilder: () => HomeViewModel());
  }
}
