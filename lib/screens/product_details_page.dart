import 'package:asuser/apis/providers.dart/product_provider.dart';
import 'package:asuser/models/product.dart';
import 'package:asuser/widgets/img_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsPage extends StatefulWidget {
  final String id;
  const ProductDetailsPage({
    Key key,
    this.id,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String _title = '';
  String _imgUrl = '';
  String _description;
  int _mrp = 0;
  int _off = 0;
  String _exp = '';
  String _store = '';
  String _category = '';
  String _destination = '';
  String _offerType = '';
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    _userData() async {
      await productProvider.getProductById(widget.id).then((Product value) {
        setState(() {
          _title = value.title;
          _imgUrl = value.imgLink;
          _description = value.description;
          _mrp = value.mrp;
          _off = value.off;
          _exp = value.exp;
          _store = value.store;
          _category = value.category;
          _destination = value.destination;
          _offerType = value.offerType;
        });
      });
    }

    try {
      _userData();
    } catch (err) {
      return Text('Error Loading $err');
    }
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: 200,
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(13),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ImgViewr(url: _imgUrl,);
                      }));
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Hero(
                            tag: 'url',
                            child: Image.network(_imgUrl, fit: BoxFit.cover))),
                  ),
                ),
                Text(
                  _title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Validity ${_exp.substring(0, 10)}',
                  style: TextStyle(color: Colors.black26, fontSize: 12),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹$_mrp',
                        style: TextStyle(
                          color: Colors.black38,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '₹$_off',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenSize.width,
                  height: 1,
                  child: Container(
                    color: Colors.black54,
                  ),
                ),
                Text(_description)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: FlatButton(
                onPressed: () {
                  launch(_destination);
                },
                child: Container(
                  height: 50,
                  color: Colors.green,
                  child: Center(
                    child: Text('Buy Now'),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
