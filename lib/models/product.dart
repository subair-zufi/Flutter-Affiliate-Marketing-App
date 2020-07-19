class Product {
  String imgLink;
  String title;
  String description;
  int mrp;
  int off;
  String exp;
  String store;
  String category;
  String subCat;
  String offerType;
  String id;
  int time;
  Product({
    this.imgLink,
    this.title,
    this.description,
    this.mrp,
    this.off,
    this.exp,
    this.store,
    this.category,
    this.subCat,
    this.offerType,
    this.id,
    this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'imgLink': imgLink,
      'title': title,
      'description': description,
      'mrp': mrp,
      'off': off,
      'exp': exp,
      'store': store,
      'category': category,
      'subCat': subCat,
      'offerType': offerType,
      'id': id,
      'time': time,
    };
  }

  Product.fromMap(Map map)
      : imgLink = map['imgLink'],
        title = map['title'],
        description = map['description'],
        mrp = map['mrp'],
        off = map['off'],
        exp = map['exp'],
        store = map['store'],
        category = map['category'],
        subCat = map['subCat'],
        offerType = map['offerType'],
        id = map['id'],
        time = map['time'];
}
