import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:unuber_mobile/models/credit_card.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_icon.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_info/credit_card_info_viewmodel.dart';
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
                      TextFormField(
                        initialValue: widget.creditCard.creditCardNumber.toString(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabled: false,
                          filled: true,
                          fillColor: appColors.fillInput,
                          prefixIcon: _creditCardIcon.creditCardConditionalIcon(
                            widget.creditCard.creditCardNumber.toString()
                          ),
                        ),
                      ),

                      SizedBox(height: 8),

                      TextFormField(
                        initialValue: widget.creditCard.dueDate,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabled: false,
                          filled: true,
                          fillColor: appColors.fillInput,
                        ),
                      ),

                      SizedBox(height: 8),

                      TextFormField(
                        initialValue: widget.creditCard.cvv,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabled: false,
                          filled: true,
                          fillColor: appColors.fillInput,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () {
                          print("Editar");
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 18,
                        ),
                        label: Text(
                          "Editar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          )
                        ),
                        style: ButtonStyle(

                        ),
                      ),

                      Divider(indent: 40),

                      TextButton.icon(
                        onPressed: () {
                          model.deleteCard(idCard: widget.creditCard.idCard!);
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 18,
                        ),
                        label: Text(
                          "Eliminar método de pago",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.red
                          ),
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
      viewModelBuilder: () => CreditCardInfoViewModel(),
    );
  }
}