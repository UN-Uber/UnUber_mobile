// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// This file contains utilities that are used in some of the credit card views,
/// in order to not have duplicated code in the mentioned views.

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
