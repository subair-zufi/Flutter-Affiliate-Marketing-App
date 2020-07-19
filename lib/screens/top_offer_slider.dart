import 'package:asuser/widgets/cerausal_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TopOfferSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Products')
          // .where('offType', isEqualTo: 'Top Offers')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new LinearProgressIndicator();
            default:
              return CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Builder(
                    builder: (BuildContext context) {
                      return CerousalCard(
                                imgLink: document['imgLink'] ?? 'no',
                                offer: document['off'].toString() ?? 'no',
                                price: document['mrp'].toString() ?? 'no',
                                title: document['title'] ?? 'no',
                                validity: document['exp'] ?? 'no',
                                id: document['id'],
                              );
                    },
                  );
                }).toList(),
              );
          }
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
