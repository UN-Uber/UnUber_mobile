// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/new_credit_card/new_credit_card_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';
import 'package:unuber_mobile/utils/custom_icons.dart';

class NewCreditCardView extends StatefulWidget {
  const NewCreditCardView({Key? key}) : super (key: key);
  @override
  _NewCreditCardViewState createState() => _NewCreditCardViewState();
}

class _NewCreditCardViewState extends State<NewCreditCardView> {

  final _formKey = GlobalKey<FormState>();
  String inputText = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, NewCreditCardViewModel model, child) => SafeArea(
        child: Scaffold(

          // AppBar 

          appBar: AppBar(
            title: const Text(
              'Agregar Tarjeta',
              style: TextStyle(
                color: Colors.white,
              )
            ),
            backgroundColor: Colors.black
          ),

          // Column

          body: SafeArea(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      EntryField(
                        tittle: 'Credit card number',
                        textType: TextInputType.number,
                        isPassword: false,
                        onChange: (text) {
                          setState(() {
                            inputText = text;
                          });
                          model.CreditCardNumberValidation;
                        },
                        errorMessage: model.error(model.cardNumberKey),
                        prefixIcon: conditionalIcon()                  
                      ),
                      EntryField(
                        tittle: 'Due date',
                        textType: TextInputType.number,
                        isPassword: false,
                        onChange: model.CreditCardDueDateValidation,
                        errorMessage: model.error(model.cardDueDateKey),
                      ),
                      EntryField(
                        tittle: 'CVV',
                        textType: TextInputType.number,
                        isPassword: false,
                        onChange: model.CreditCardCvvValidation,
                        errorMessage: model.error(model.cardCvvKey),                   
                      ),
                    ],
                  ),

                )
              ]
            ),
          ),

        )
      ),
      viewModelBuilder: () => NewCreditCardViewModel(),
    );
  }

  IconData conditionalIcon() {
    if(inputText.startsWith("4")){
      return MyApp.visa;
    }
    else if(inputText.startsWith("5")){
      return MyApp.master_mastercard;
    }
    else{
      return Icons.credit_card_sharp;
    }
  }
}

