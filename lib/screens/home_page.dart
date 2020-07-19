import 'package:asuser/screens/top_offer_slider.dart';
import 'package:asuser/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  stream: Firestore.instance
                      .collection('Products')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new LinearProgressIndicator();
                        default:
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
