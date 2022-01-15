// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/models/credit_card.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_info/credit_card_info_viewmodel.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_utils.dart';
import 'package:unuber_mobile/ui/widgets/atoms/entry_field.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class CreditCardInfo extends StatefulWidget {
  const CreditCardInfo({Key? key, required this.creditCard}): super(key: key);

  final CreditCard creditCard;

  @override
  _CreditCardsInfoViewState createState() => _CreditCardsInfoViewState();
}

class _CreditCardsInfoViewState extends State<CreditCardInfo>{

  final CreditCardIcon _creditCardIcon = new CreditCardIcon();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, CreditCardInfoViewModel model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Detalles de la tarjeta"),
          ),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Form(
                  child: Column(
                    children: <Widget>[
                      EntryField(
                        title: 'Tarjeta',
                        initialValue: initialValueFormat(
                          widget.creditCard.creditCardNumber.toString()),
                        textType: TextInputType.number,
                        inputFormatters: [
                          MaskedTextInputFormatter(mask: "#### #### #### ####", separator: " ")
                        ],
                        onChange: (text) {
                          model.changeCreditCard(text.replaceAll(" ", ""));
                        },
                        errorMessage: model.creditCardError,
                        isEnabled: model.editEnable,
                        prefixIcon: _creditCardIcon.creditCardConditionalIcon(
                          widget.creditCard.creditCardNumber.toString()
                        ),
                      ),

                      EntryField(
                        title: 'Fecha de vencimiento',
                        initialValue: widget.creditCard.dueDate,
                        textType: TextInputType.number,
                        inputFormatters: [
                          MaskedTextInputFormatter(mask: "##/##", separator: "/")
                        ],
                        onChange: model.changeDueDate,
                        errorMessage: model.dueDateError,
                        isEnabled: model.editEnable,
                      ),

                      EntryField(
                        title: 'CVV',
                        initialValue: widget.creditCard.cvv,
                        textType: TextInputType.number,
                        inputFormatters: [
                          MaskedTextInputFormatter(mask: "###", separator: "")
                        ],
                        onChange: model.changeCvv,
                        errorMessage: model.cvvError,
                        isEnabled: model.editEnable,
                      ),
                    ],
                  ),
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Visibility(
                      visible: !model.editEnable,
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 18,
                        ),
                        title: Text(
                          "Editar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          )
                        ),
                        onTap: () {
                          model.enableEdit();
                        },
                      ),
                    ),
                    
                    Divider(indent: 40),

                    Visibility(
                      visible: !model.editEnable,
                      child: ListTile(
                        leading: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 18,
                        ),
                        title: Text(
                          "Eliminar método de pago",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red
                          )
                        ),
                        onTap: () {
                          model.deleteCard(idCard: widget.creditCard.idCard!);
                        },
                      ),
                    ),

                    Visibility(
                      visible: model.editEnable,
                      child: SubmitButton(
                        onPressed: () {
                          if(model.dataAreChange()){
                            model.updateCard(idCard: widget.creditCard.idCard!);
                            if(model.updated){
                              final snackBar = SnackBar(
                              backgroundColor: appColors.primaryVariant,
                              content: Text("Tarjeta actualizada"),
                              action: SnackBarAction(
                                label: 'Cerrar', 
                                onPressed: () {}));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                          else{
                            final snackBar = SnackBar(
                              backgroundColor: appColors.secondaryVariant,
                              content: Text("Sin cambios por realizar"),
                              action: SnackBarAction(
                                label: 'Cerrar', 
                                onPressed: () {}));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        text: 'Guardar cambios',
                      ),
                    ),

                    Divider(indent: 40),

                    Visibility(
                      visible: model.editEnable,
                      child: OutlinedButton(
                        onPressed: () {
                          model.enableEdit();
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          primary: Colors.white
                        ),
                        child: Text(
                          "Cancelar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: appColors.primary
                          ),
                        )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
      viewModelBuilder: () => CreditCardInfoViewModel(),
    );
  }


  /// The initialValueFormat method allows to format an original string to
  /// a formatted string, in this case this method is only used to format the
  /// initial value of the credit card number input
  /// - @Param value is the string to be formatted
  /// - return the original string with the format
  /// 
  initialValueFormat(String value){
    if(value == '') return '';
    var mask = "#### #### #### ####";
    value.split("").forEach((element) => { mask = mask.replaceFirst('#', element)});
    return mask.replaceAll('#', '');
  }
}
