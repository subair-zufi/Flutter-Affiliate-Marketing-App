import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String imgLink;
  final String title;
  final String price;
  final String offer;
  final String validity;

  const ProductCard({
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
    var screenSize = MediaQuery.of(context).size;
    var myWidth = screenSize.width > 600 ? 600 : screenSize.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Container(
          width: myWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.05),
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                // margin: EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imgLink,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹$price',
                        style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '₹$offer',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Validity ${validity.substring(0, 10)}',
                        style: TextStyle(color: Colors.black26, fontSize: 12),
                      ),

                      // Text('Amazone')
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
