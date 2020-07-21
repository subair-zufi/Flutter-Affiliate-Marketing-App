import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:asuser/models/product.dart';
import 'package:asuser/screens/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var myWidth = screenSize.width > 600 ? 600 : screenSize.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ProductDetailsPage(
              id: product.id,
            );
          }));
        },
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
                    product.imgLink,
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
                      product.title,
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
                        '₹${product.mrp}',
                        style: TextStyle(
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '₹${product.off}',
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
                        'Validity ${product.exp.substring(0, 10)}',
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
