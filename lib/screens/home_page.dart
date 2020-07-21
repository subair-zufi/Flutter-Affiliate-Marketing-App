import 'package:asuser/apis/providers.dart/product_provider.dart';
import 'package:asuser/models/product.dart';
import 'package:asuser/screens/top_offer_slider.dart';
import 'package:asuser/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    List<Product> productList;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(title: Text('Home')),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(13),
          child: ListView(
            shrinkWrap: true,
            children: [
              TopOfferSlider(),
              StreamBuilder<QuerySnapshot>(
                  stream: productProvider.fetchProductsAsStream(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      productList = snapshot.data.documents
                          .map(
                            (doc) => Product.fromMap(doc.data),
                          )
                          .toList();
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new LinearProgressIndicator();
                        default:
                          return Wrap(
                              children:
                                  productList.map((e) => ProductCard(
                                    product: e,
                                  )).toList()

                             
                              );
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          )),
    );
  }
}
