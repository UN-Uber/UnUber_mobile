class User {
  int? idClient;
  String fName = "";
  String sName = "";
  String sureName = "";
  int active = 0;
  String email = "";
  String telNumber = "";
  String? password = "";
  String image = "";

  User(
      {this.idClient,
      required this.fName,
      required this.sName,
      required this.sureName,
      required this.active,
      required this.email,
      required this.telNumber,
      this.password,
      required this.image});
}
