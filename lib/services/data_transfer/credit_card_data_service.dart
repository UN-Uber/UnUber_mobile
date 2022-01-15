class CreditCardDataService{

  String _selectedCreditCardNumber = '';
  String _selectedCreditCardDueDate = '';
  String _selectedCreditCardCvv = '';

  String get selectedCreditCardNumber => this._selectedCreditCardNumber;
  String get selectedCreditCardDueDate => this._selectedCreditCardDueDate;
  String get selectedCreditCardCvv => this._selectedCreditCardCvv;


  /// The method selectedCreditCardInfo set the infomartion of a selected credit card
  /// like card number, due date and cvv, this allows to the CreditCardInfoViewModel access
  /// to this information and can compare the original info with the edited info.
  /// 
  /// All this because the view model cannot directly access to the data of the view received
  /// through nativation 
  /// 
  selectedCreditCardInfo(int number, String date, String cvv){
    this._selectedCreditCardNumber = number.toString();
    this._selectedCreditCardDueDate = date;
    this._selectedCreditCardCvv = cvv;
  }
}