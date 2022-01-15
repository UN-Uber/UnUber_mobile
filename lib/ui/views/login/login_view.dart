// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/login/login_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/bezier_container.dart';
import 'package:unuber_mobile/ui/widgets/atoms/loading_indicator.dart';
import 'package:unuber_mobile/ui/widgets/organisms/login_form/login_form_view.dart';

/// The class Login View is the view for the login route
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        builder: (context, LoginViewModel model, child) => SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: <Widget>[
                  Positioned(
                    top: -(_screenSize.height * .225),
                    right: -(_screenSize.width * .4),
                    child: BezierContainer(),
                  ),
                  Column(
                    children: <Widget>[
                      model.isLoading
                          ? LoadingIndicator()
                          : Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: LoginForm(
                                      onSubmit: model.login,
                                      changeNumber: model.updateTelephone)))
                    ],
                  )
                ],
              ),
            )),
        viewModelBuilder: () => LoginViewModel());
  }
}
