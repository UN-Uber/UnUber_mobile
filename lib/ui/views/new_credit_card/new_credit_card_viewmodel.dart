// Package imports:
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Project imports:
import 'package:unuber_mobile/app/app.locator.dart';
import 'package:unuber_mobile/app/app.router.dart';
import 'package:unuber_mobile/services/validations/credit_card_validation_service.dart';

class NewCreditCardViewModel extends MultipleStreamViewModel {

  final CreditCardValidationService _creditCardValidationService = locator<CreditCardValidationService>();  
  
  final String _cardNumberKey = 'card-stream';
  final String _cardDueDateKey = 'date-stream';
  final String _cardCvvKey = 'cvv-stream';
  
  String get cardNumberKey => _cardNumberKey;
  String get cardDueDateKey => _cardDueDateKey;
  String get cardCvvKey => _cardCvvKey;
  
  @override
  Map<String, StreamData> get streamsMap => {
    _cardNumberKey: StreamData(_creditCardValidationService.cardNumber),
    _cardDueDateKey: StreamData(_creditCardValidationService.dueDate),
    _cardCvvKey: StreamData(_creditCardValidationService.cvv)
  };

  CreditCardNumberValidation(String value) => _creditCardValidationService.cardNumberSink.add(value);
  CreditCardDueDateValidation(String value) => _creditCardValidationService.dueDateSink.add(value);
  CreditCardCvvValidation(String value) => _creditCardValidationService.cvvSink.add(value);

}
