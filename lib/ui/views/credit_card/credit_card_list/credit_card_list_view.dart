// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:stacked/stacked.dart';

// Project imports:
import 'package:unuber_mobile/models/credit_card.dart';
import 'package:unuber_mobile/ui/views/credit_card/credit_card_list/credit_card_list_viewmodel.dart';
import 'package:unuber_mobile/ui/widgets/atoms/submit_button.dart';

class CreditCardsListView extends StatefulWidget {
  const CreditCardsListView({Key? key}): super(key: key);
  @override
  _CreditCardsListViewState createState() => _CreditCardsListViewState();
}

class _CreditCardsListViewState extends State<CreditCardsListView> {

  late Future<List<CreditCard>> _cards;
  CreditCardListViewModel model = new CreditCardListViewModel();
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
            backgroundColor: Colors.black
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
                      title: Text("**** "+item!.toString().substring(l-4,l)),
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
}
