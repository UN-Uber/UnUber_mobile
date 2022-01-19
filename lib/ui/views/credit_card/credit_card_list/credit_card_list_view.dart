// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/models/credit_card.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_info/credit_card_info_view.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_list/credit_card_list_viewmodel.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_utils.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class CreditCardsListView extends StatefulWidget {
  const CreditCardsListView({Key? key}): super(key: key);
  @override
  _CreditCardsListViewState createState() => _CreditCardsListViewState();
}

class _CreditCardsListViewState extends State<CreditCardsListView> {

  late Future<List<CreditCard>> _cards;
  CreditCardListViewModel model = new CreditCardListViewModel();
  final CreditCardIcon _creditCardIcon = new CreditCardIcon();
  @override
  void initState() {
    super.initState();
    _cards = model.listUserCards();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, CreditCardListViewModel model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Billetera',
              style: TextStyle(
                color: Colors.white,
              )
            ),
            backgroundColor: appColors.primary
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              model.navigateToAddCreditCard();
            },
            backgroundColor: appColors.primary,
            icon: Icon(Icons.add),
            label: Text('Agregar'),
          ),

          body: FutureBuilder<List<CreditCard>>(
            future: _cards,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext _context, int i) {
                    final item = snapshot.data?.elementAt(i).creditCardNumber;
                    final int l = item.toString().length;
                    return ListTile(
                      leading: _creditCardIcon.creditCardConditionalIcon(item.toString()),
                      title: Text(displayFormatCardNumber(item!)),
                      onTap: () {
                        CreditCard card;
                        card = snapshot.data!.elementAt(i);
                        model.selectedCreditCardInfo(card.creditCardNumber, card.dueDate, card.cvv);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreditCardInfo(creditCard: card),
                          ),
                        );
                      },
                    );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          ),
        ),
      ),
      viewModelBuilder: () => CreditCardListViewModel(),
    );
  }

  /// The method displayFormatCardNumber format the credit card as follows
  /// XXXX XXXX XXXX XXXX
  /// - @Param int number is the credit card number
  /// - Return String with the previous format
  /// 
  String displayFormatCardNumber(int number){
    String cardNumber = number.toString();
    String formated = "";
    int l = cardNumber.length, count = 0;
    while(count < l){
      formated += cardNumber.substring(count, count+ 4) + " ";
      count += 4;
    }

    return formated;
  }
}
