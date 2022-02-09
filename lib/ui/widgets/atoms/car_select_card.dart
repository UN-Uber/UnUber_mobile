import 'package:flutter/material.dart';

class CarSelectCard extends StatelessWidget {
  final String title, price;

  const CarSelectCard({ Key? key, required this.title, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage('assets/images/service_car.png'),
            height: 80),
          Text(this.title, style: TextStyle(fontSize: 20)),
          Text(this.price, style: TextStyle(fontSize: 20))
        ],
      ));
  }
}
