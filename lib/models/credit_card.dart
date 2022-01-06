class CreditCard {
  int? _idCard;
  int? _idClient;
  int _creditCardNumber = 0;
  String _dueDate = '';
  String _cvv = '';

  CreditCard({
    int? idCard,
    int? idClient,
    required int creditCardNumber,
    required String dueDate,
    required String cvv
  }){
    this._idCard = idCard;
    this._idClient = idClient;
    this._creditCardNumber = creditCardNumber;
    this._dueDate = dueDate;
    this._cvv = cvv;
  }

}