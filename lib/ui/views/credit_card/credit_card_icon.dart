// Flutter imports:
import 'package:flutter/material.dart';

class CreditCardIcon{

  /// The creditCardConditionalIcon function change the credit card prefixIcon in function
  /// of the number of this. Return the Visa or MasterCard icon if the number complies
  /// with the defined prefix or a default credit card icon if the number doesn't complies
  /// with the defined prefixes.
  /// 
  Widget creditCardConditionalIcon(String number){
    String img = "";

    // Prefix of the Visa cards
    if(number.startsWith("4")){
      img = 'visa_icon.png';
    }

    // Prefixes of the MasterCard cards
    else if(number.startsWith("51") || number.startsWith("52") ||
            number.startsWith("53") || number.startsWith("54") ||
            number.startsWith("55")
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

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Image(
        image: AssetImage('assets/images/$img'),
        width: 20.0,
      )
    );
  }

}
