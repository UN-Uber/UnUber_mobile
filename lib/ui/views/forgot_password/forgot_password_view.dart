// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/forgot_password/forgot_password_viewmodel.dart';

/// The class ForgotPasswordView is the view for the forgot password route
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, ForgotPasswordViewModel model, child) => SafeArea(
        child: Scaffold(
          body: Container()
        )
      ),
      viewModelBuilder: () => ForgotPasswordViewModel()
    );
  }
}
