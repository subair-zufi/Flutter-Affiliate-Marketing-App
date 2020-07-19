import 'package:asuser/models/product.dart';
import 'package:asuser/widgets/input_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  var _imgLink;
  var _title;
  var _description;
  var _mrp;
  var _off;
  var _exp;
  var _store = 'Amazone';
  var _category = 'Mobiles';
  var _subCat = 'Bags';
  var _offType = 'General';

  DateTime selectedDate = DateTime.now();
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _exp = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String productId =
        Firestore.instance.collection('Products').document().documentID;
    var productRef =
        Firestore.instance.collection('Products').document(productId);
    void _saveAll() async {
      var isValid = _formKey.currentState.validate();
      if (isValid) {
        setState(() {
          isLoading = true;
        });
        _formKey.currentState.save();
        productRef
            .setData(Product(
              category: _category,
              description: _description,
              exp: _exp.toString(),
              id: productId,
              imgLink: _imgLink,
              mrp: _mrp,
              off: _off,
              offerType: _offType,
              store: _store,
              subCat: _subCat,
              time: DateTime.now().millisecondsSinceEpoch.toInt(),
              title: _title,
            ).toMap())
            .then((value) => Navigator.pop(context, 'Success'));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveAll,
          )
        ],
      ),
      body: Center(
          child: !isLoading
              ? Container(
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        InputBox(
                          icon: Icons.insert_link,
                          labelText: 'Image Link',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'paste a link here';
                            } else
                              return null;
                          },
                          onSaved: (value) {
                            _imgLink= value;
                          },
                        ),
                        InputBox(
                          icon: Icons.insert_link,
                          labelText: 'Title',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'enter a valid title';
                            } else
                              return null;
                          },
                          onSaved: (value) {
                            _title= value;
                          },
                        ),
                        InputBox(
                          icon: Icons.insert_link,
                          labelText: 'Description',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'enter a description';
                            } else
                              return null;
                          },
                          onSaved: (value) {
                            _description= value;
                          },
                        ),
                        InputBox(
                          icon: Icons.insert_link,
                          labelText: 'Max. R.Price',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter the price';
                            } else
                              return null;
                          },
                          onSaved: (value) {
                            _mrp= int.parse(value);
                          },
                        ),
                        InputBox(
                          icon: Icons.insert_link,
                          labelText: 'Offer Price',
                          onSaved: (value) {
                            _off= int.parse(value);
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.only(right: 13, left: 13, bottom: 8),
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.black.withOpacity(.2),
                          ),
                          child: FlatButton(
                            onPressed: () => _selectDate(context),
                            child: Row(
                              children: [
                                Icon(Icons.date_range),
                                Text(
                                  _exp != null
                                      ? _exp.toString()
                                      : 'Select Date',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.only(right: 13, left: 13, bottom: 8),
                          padding: EdgeInsets.only(left: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.black.withOpacity(.2),
                          ),
                          child: DropdownButton<String>(
                            value: _store,
                            onChanged: (String newValue) {
                              setState(() {
                                _store = newValue;
                              });
                            },
                            items: <String>['Amazone', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.only(right: 13, left: 13, bottom: 8),
                          padding: EdgeInsets.only(left: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.black.withOpacity(.2),
                          ),
                          child: DropdownButton<String>(
                            value: _category,
                            onChanged: (String newValue) {
                              setState(() {
                                _category = newValue;
                              });
                            },
                            items: <String>['Mobiles', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(right: 13, left: 13),
                          padding: EdgeInsets.only(left: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.black.withOpacity(.2),
                          ),
                          child: DropdownButton<String>(
                            value: _subCat,
                            onChanged: (String newValue) {
                              setState(() {
                                _subCat = newValue;
                              });
                            },
                            items: <String>['Bags', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(right: 13, left: 13),
                          padding: EdgeInsets.only(left: 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Colors.black.withOpacity(.2),
                          ),
                          child: DropdownButton<String>(
                            value: _offType,
                            onChanged: (String newValue) {
                              setState(() {
                                _offType = newValue;
                              });
                            },
                            items: <String>['General', 'Top Offer']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : CircularProgressIndicator()),
    );
  }
}
