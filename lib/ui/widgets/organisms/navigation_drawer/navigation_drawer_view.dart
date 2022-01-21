// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/organisms/navigation_drawer/navigation_drawer_viewmodel.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class NavigationDrawerView extends StatelessWidget {
  final Function()? accountTap;
  const NavigationDrawerView({Key? key, required this.accountTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        builder: (context, NavigationDrawerViewModel model, child) => SafeArea(
                child: Drawer(
                    child: ListView(children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      color: appColors.primary,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(model.landscape))),
                  accountName: Text(model.user),
                  accountEmail: Text(model.email),
                  currentAccountPicture: CircleAvatar(
                      child: ClipOval(
                          child:
                              Image(image: AssetImage(model.profileImage))))),
              ListTile(
                title: Text('Account'),
                onTap: model.goToAccount,
              ),
              ListTile(
                title: Text('Billetera'),
                onTap: model.goToCreditCard,
              ),
              ListTile(
                title: Text('Cerrar Sesión'),
                onTap: model.logout,
              )
            ]))),
        viewModelBuilder: () => NavigationDrawerViewModel());
  }
}
