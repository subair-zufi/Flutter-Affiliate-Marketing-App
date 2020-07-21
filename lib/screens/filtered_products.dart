import 'package:asuser/apis/providers.dart/product_provider.dart';
import 'package:asuser/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:asuser/widgets/product_card.dart';
import 'package:provider/provider.dart';

class FilteredProductsPage extends StatelessWidget {
  final String storeFilter;
  final String categoryFilter;
  const FilteredProductsPage({
    Key key,
    this.storeFilter,
    this.categoryFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    List<Product> productList;
    _filter() {
      if (storeFilter != null) {
        return  productProvider.fetchProductsStoreWise(storeFilter);
      } else if (categoryFilter != null) {
        return  productProvider.fetchProductsCategoryWise(categoryFilter);
      } else {
        return productProvider.fetchProductsAsStream();
      }
    }
print(storeFilter??categoryFilter);
    return Scaffold(
      appBar: AppBar(
        title: Text(storeFilter != null ? storeFilter : categoryFilter),
      ),
      body: Container(
          padding: EdgeInsets.all(13),
          child: ListView(
            shrinkWrap: true,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _filter(),
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
                          var titleList = snapshot.data.documents
                              .map((DocumentSnapshot document) =>
                                  document['mrp'].toString())
                              .toList();
                          print(titleList);

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
