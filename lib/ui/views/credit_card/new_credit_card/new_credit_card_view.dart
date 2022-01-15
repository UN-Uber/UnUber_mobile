// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/credit_card/credit_card_utils.dart';
import 'package:unuber_mobile/ui/views/credit_card/new_credit_card/new_credit_card_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';

class NewCreditCardView extends StatefulWidget {
  const NewCreditCardView({Key? key}) : super (key: key);
  @override
  _NewCreditCardViewState createState() => _NewCreditCardViewState();
}

class _NewCreditCardViewState extends State<NewCreditCardView> {

  final CreditCardIcon _creditCardIcon = new CreditCardIcon();
  final _formKey = GlobalKey<FormState>();
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, NewCreditCardViewModel model, child) => SafeArea(
        child: Scaffold(

          appBar: AppBar(
            title: const Text(
              'Agregar Tarjeta',
              style: TextStyle(
                color: Colors.white,
              )
            ),
            backgroundColor: Colors.black
          ),

          body: SafeArea(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      EntryField(
                        title: 'Credit card number',
                        textType: TextInputType.number,
                        isPassword: false,
                        onChange: (text) {
                          setState(() {
                            inputText = text;
                          });
                          model.changeCreditCard(text.replaceAll(" ", ""));
                        },
                        errorMessage: model.creditCardError,
                        inputFormatters: [
                          MaskedTextInputFormatter(
                            mask: 'xxxx xxxx xxxx xxxx',
                            separator: ' ',
                          ),
                        ],
                        prefixIcon: _creditCardIcon.creditCardConditionalIcon(inputText)                 
                      ),

                      EntryField(
                        title: 'Due date',
                        textType: TextInputType.number,
                        isPassword: false,
                        onChange: model.changeDueDate,
                        errorMessage: model.dueDateError,
                        inputFormatters: [
                          MaskedTextInputFormatter(
                            mask: 'xx/xx',
                            separator: '/'
                          ),
                        ],
                      ),

                      EntryField(
                        title: 'CVV',
                        textType: TextInputType.number,
                        isPassword: false,
                        onChange: model.changeCvv,
                        errorMessage: model.cvvError,
                        inputFormatters: [
                          MaskedTextInputFormatter(mask: "###", separator: "")
                        ],                
                      ),
                    ],
                  ),
                ),

                SubmitButton(text: "Agregar", onPressed: () {
                  if (model.isValidForm) model.createCard();
                  else {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text("Verifica los campos"),
                      action: SnackBarAction(
                        label: 'Cerrar',
                        textColor: Colors.white,
                        onPressed: () {}
                        )
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                      }
                })
              ]
            ),
          ),
        )
      ),
      viewModelBuilder: () => NewCreditCardViewModel(),
    );
  }
}