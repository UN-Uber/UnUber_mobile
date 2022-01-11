// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/signup/signup_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/bezier_container.dart';
import 'package:unuber_mobile/ui/widgets/atoms/loading_indicator.dart';
import 'package:unuber_mobile/ui/widgets/organisms/signup_form/signup_form_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
        builder: (context, SignupViewModel model, child) => SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Stack(children: <Widget>[
                  Positioned(
                      top: -(_screenSize.height * .225),
                      right: -(_screenSize.width * .4),
                      child: BezierContainer()),
                  Column(children: <Widget>[
                    model.isLoading
                        ? LoadingIndicator()
                        : Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: SignupFormView(
                                onSubmit: model.signup,
                              ),
                            ),
                          )
                  ])
                ]))),
        viewModelBuilder: () => SignupViewModel());
  }
}
