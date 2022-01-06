// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:unuber_mobile/services/validations/validators.dart';

class CreditCardValidationService with Validators {
  final _creditCardController = BehaviorSubject<String>.seeded('');
  final _dueDateController = BehaviorSubject<String>.seeded('');
  final _cvvController = BehaviorSubject<String>.seeded('');

  Stream<String> get cardNumber => _creditCardController.stream.transform(validateCreditCardNumber);
  Sink<String> get cardNumberSink => _creditCardController.sink;

  Stream<String> get dueDate => _dueDateController.stream.transform(validateDueDate);
  Sink<String> get dueDateSink => _dueDateController.sink;

  Stream<String> get cvv => _cvvController.stream.transform(validateCVV);
  Sink<String> get cvvSink => _cvvController.sink;

  dispose(){
    _creditCardController.close();
    _dueDateController.close();
    _cvvController.close();
  }
}
