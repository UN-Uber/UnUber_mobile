// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:unuber_mobile/models/user.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/user/user_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/organisms/navigation_drawer/navigation_drawer_view.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;
import 'package:unuber_mobile/ui/widgets/atoms/bezier_container.dart';
import 'package:unuber_mobile/ui/widgets/atoms/loading_indicator.dart';
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';

/// The class HomeView is the view for the home route

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  UserViewModel userViewModel = new UserViewModel();
  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = userViewModel.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        builder: (context, UserViewModel model, child) => SafeArea(
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
                body: FutureBuilder<User>(
                    future: _user,
                    builder: (context, snapshut) {
                      if (snapshut.hasData) {
                        User? user = snapshut.data;
                        return Stack(
                          children: <Widget>[
                            Positioned(
                              top: -(_screenSize.height * .225),
                              right: -(_screenSize.width * .4),
                              child: BezierContainer(),
                            ),
                            Column(children: <Widget>[
                              EntryField(
                                initialValue: user!.fName +
                                    " " +
                                    (user.sName != null ? user.sName! : ""),
                                textType: TextInputType.name,
                                onChange: model.changeName,
                                errorMessage: model.nameError,
                                title: "Nombre",
                              ),
                              EntryField(
                                initialValue: user.sureName,
                                textType: TextInputType.name,
                                onChange: model.changeSurename,
                                errorMessage: model.surenameError,
                                title: "Apellido(s)",
                              ),
                              EntryField(
                                initialValue: user.email,
                                textType: TextInputType.emailAddress,
                                onChange: model.changeEmail,
                                errorMessage: model.emailError,
                                title: "Email",
                                isEnabled: false,
                              ),
                              EntryField(
                                initialValue: user.telNumber,
                                textType: TextInputType.emailAddress,
                                onChange: model.changeTelephone,
                                errorMessage: model.telephoneError,
                                title: "Teléfono",
                                isEnabled: false,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () => {model.updateUser()},
                                  child: Text("Actualizar"),
                                  style: ElevatedButton.styleFrom(
                                      primary: appColors.blackButton)),
                              SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () => {model.deleteUser()},
                                  child: Text("Eliminar Usuario"),
                                  style: ElevatedButton.styleFrom(
                                      primary: appColors.primary)),
                            ])
                          ],
                        );
                      }
                      return LoadingIndicator();
                    }),
              ),
            ),
        viewModelBuilder: () => UserViewModel());
  }
}
