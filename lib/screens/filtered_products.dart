import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:asuser/widgets/product_card.dart';

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
    var productRef = Firestore.instance.collection('Products');
    _filter() {
      if (storeFilter != null) {
        return productRef
            .where('store', isEqualTo: storeFilter)
            .orderBy('time', descending: true)
            .snapshots();
      } else if (categoryFilter != null) {
        return productRef
            .where('category', isEqualTo: categoryFilter)
            .orderBy('time', descending: true)
            .snapshots();
      } else {
        return productRef.orderBy('time', descending: true).snapshots();
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
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return ProductCard(
                                imgLink: document['imgLink'] ?? 'no',
                                offer: document['off'].toString() ?? 'no',
                                price: document['mrp'].toString() ?? 'no',
                                title: document['title'] ?? 'no',
                                validity: document['exp'] ?? 'no',
                                id: document['id'],
                              );
                            }).toList(),
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
