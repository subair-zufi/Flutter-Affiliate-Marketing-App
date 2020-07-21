import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;
  String uid;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  void inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }

  //filters
  Stream<QuerySnapshot> streamWithStoreFilter(String store) {
    return ref.where('store', isEqualTo: store).snapshots();
  }

  Stream<QuerySnapshot> streamWithCategoryFilter(String category) {
    return ref.where('category', isEqualTo: category).snapshots();
  }
}
