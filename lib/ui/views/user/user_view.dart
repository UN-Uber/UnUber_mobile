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
                                initialValue: user!.fName,
                                textType: TextInputType.text,
                                onChange: (Value) {},
                                errorMessage: "",
                                title: "Primer Nombre",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              EntryField(
                                initialValue:
                                    user.sName != null ? user.sName! : "",
                                textType: TextInputType.text,
                                onChange: (Value) {},
                                errorMessage: "",
                                title: "Segundo Nombre",
                              ),
                              EntryField(
                                initialValue: user.sureName,
                                textType: TextInputType.text,
                                onChange: (Value) {},
                                errorMessage: "",
                                title: "Apellido(s)",
                              ),
                              EntryField(
                                initialValue: user.sureName,
                                textType: TextInputType.text,
                                onChange: (Value) {},
                                errorMessage: "",
                                title: "Email",
                              ),
                              EntryField(
                                initialValue: user.sureName,
                                textType: TextInputType.text,
                                onChange: (Value) {},
                                errorMessage: "",
                                title: "Teléfono",
                              ),
                              TextFormField(
                                initialValue: "por si acaso",
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    enabled: false,
                                    filled: true,
                                    fillColor: appColors.fillInput),
                              ),
                              ElevatedButton(
                                  onPressed: () => {model.getUser()},
                                  child: Text("Actualizar"))
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
