import 'package:flutter/material.dart';

class ImgViewr extends StatelessWidget {
  final String url;
  const ImgViewr({
    Key key,
    this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(
        width: MediaQuery.of(context).size.width,
        child: Hero(tag: 'url', 
          child: Image.network(url, fit: BoxFit.fill,)),
      ),),
    );
  }
}
