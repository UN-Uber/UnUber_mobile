// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';
import 'package:unuber_mobile/ui/widgets/atoms/main_title.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';
import 'package:unuber_mobile/ui/widgets/organisms/signup_form/signup_form_viewmodel.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class SignupFormView extends StatelessWidget {
  final Function onSubmit;
  const SignupFormView({ Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _screenSize= MediaQuery.of(context).size;
    return ViewModelBuilder.reactive(
      builder: (context, SignupFormViewModel model, child) => SafeArea(
        child: WillPopScope(
                onWillPop: null,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MainTitle(
                          text: model.title,
                          color: appColors.primaryVariant,
                          fontSize: 30),
                      SizedBox(height: _screenSize.height * .025),
                      Column(children: <Widget>[
                        EntryField(
                            title: 'Nombre',
                            textType: TextInputType.name,
                            onChange: model.changeName,
                            errorMessage: model.nameError
                        ),
                        EntryField(
                            title: 'Apellido',
                            textType: TextInputType.name,
                            onChange: model.changeSurename,
                            errorMessage: model.surenameError
                        ),
                        EntryField(
                            title: 'Correo electronico',
                            textType: TextInputType.emailAddress,
                            onChange: model.changeEmail,
                            errorMessage: model.emailError
                        ),
                        EntryField(
                            title: 'Número telefonico',
                            textType: TextInputType.emailAddress,
                            onChange: model.changeTelephone,
                            errorMessage: model.telephoneError
                        ),
                        EntryField(
                            title: 'Contraseña',
                            textType: TextInputType.visiblePassword,
                            isPassword: true,
                            onChange: model.changePassword,
                            errorMessage: model.passwordError),
                        EntryField(
                            title: 'Confirmar contraseña',
                            textType: TextInputType.visiblePassword,
                            isPassword: true,
                            onChange: model.changeConfirmPassword,
                            errorMessage: model.confirmPasswordError)
                      ]),
                      SizedBox(height: _screenSize.height * .04),
                      Column(children: <Widget>[
                        SubmitButton(
                                text: model.signupButtonText,
                                onPressed: () {
                                  if (model.isValidForm) {
                                    onSubmit();
                                  } else {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.redAccent,
                                        content: Text(model.snackBarError),
                                        action: SnackBarAction(
                                            label: 'Cerrar', onPressed: () {}));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                              )
                      ])
                    ]))
      ),
      viewModelBuilder: () => SignupFormViewModel(),
    );
  }
}
