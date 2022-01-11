class CreditCard {
  int? idCard;
  int? idClient;
  int creditCardNumber = 0;
  String dueDate = '';
  String cvv = '';

  CreditCard({
    this.idCard,
    this.idClient,
    required this.creditCardNumber,
    required this.dueDate,
    required this.cvv
  });
}