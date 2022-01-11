// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/ui/views/credit_card/new_credit_card/new_credit_card_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';

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
                        prefixIcon: conditionalIcon()                 
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


  /// The conditionalIcon function change the credit card prefixIcon in function
  /// of the number of this. Return the Visa or MasterCard icon if the number complies
  /// with the defined prefix or a default credit card icon if the number doesn't complies
  /// with the defined prefixes.
  /// 
  Widget conditionalIcon() {
    String img = "";

    // Prefix of the Visa cards
    if(inputText.startsWith("4")){
      img = 'visa_icon.png';
    }

    // Prefixes of the MasterCard cards
    else if(inputText.startsWith("51") || inputText.startsWith("52") ||
            inputText.startsWith("53") || inputText.startsWith("54") ||
            inputText.startsWith("55")
          )
          {
            img = 'mastercard_icon.png';
          }
    else{
      return Icon(
        Icons.credit_card,
        size: 30.0,
        color: Colors.grey[600],
      );
    }

    return Image(
      image: AssetImage('assets/images/$img'),
      width: 20.0,
    );
  }
}


/// The MaskedTextInputFormatter class allows configure a Format for the text
/// in a TextField from a mask and a separator which are declared in the attribute
/// inputFormatters[] of the EntryField widget
/// 
/// Example:
/// EntryField( 
///   ...
///   inputFormatters: [
///     MaskedTextInputFormatter(
///       mask: 'xx/xx',
///       separator: '/',
///     )
///   ]
///   ...
/// )
/// 
class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue){
    if(newValue.text.length > 0){
      if(newValue.text.length > oldValue.text.length){
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator){
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1),
          );
        }
      }
    }
    return newValue;
  }
}