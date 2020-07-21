import 'package:flutter/material.dart';

class CerousalCard extends StatelessWidget {
  final String id;
  final String imgLink;
  final String title;
  final String price;
  final String offer;
  final String validity;
  const CerousalCard({
    Key key,
    this.id,
    this.imgLink,
    this.title,
    this.price,
    this.offer,
    this.validity,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imgLink,
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
          bottom: 5,
          left: 15,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '₹$price',
                style: TextStyle(
                    color: Colors.black38,
                    decoration: TextDecoration.lineThrough,
                    ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                '₹$offer',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        )
      ],
    );
  }
}
