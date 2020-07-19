import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String email;
  String displayName;
  String picUrl;
  User({
    this.uid,
    this.email,
    this.displayName,
    this.picUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'picUrl': picUrl,
    };
  }

  saveData() async {
    Firestore.instance
        .collection('Users')
        .document(uid)
        .setData(toMap())
        .then((value) => print(displayName));
  }
}
