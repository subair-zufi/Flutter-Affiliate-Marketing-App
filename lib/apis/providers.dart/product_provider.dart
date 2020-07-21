import 'package:asuser/apis/firestore_api.dart';
import 'package:asuser/locator.dart';
import 'package:asuser/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  Api _api = productLocator<Api>();

  List<Product> products;

  Future<List<Product>> fetchproducts() async {
    var result = await _api.getDataCollection();
    products =
        result.documents.map((doc) => Product.fromMap(doc.data)).toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Product> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Product.fromMap(doc.data);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(Product data, String id) async {
    await _api.updateDocument(data.toMap(), id);
    return;
  }

  //filters
  Stream<QuerySnapshot> fetchProductsStoreWise(String store) {
    return _api.streamWithStoreFilter(store);
  }

  Stream<QuerySnapshot> fetchProductsCategoryWise(String category) {
    return _api.streamWithCategoryFilter(category);
  }
}
