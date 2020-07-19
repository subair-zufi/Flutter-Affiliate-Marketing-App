import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String labelText;
  final Function validator;
  final Function onSaved;
  final IconData icon;
  const InputBox({
    Key key,
    this.labelText,
    this.validator,
    this.onSaved,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          icon: Icon(icon),
          border: OutlineInputBorder(), 
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
