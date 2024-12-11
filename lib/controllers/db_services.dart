import 'package:cloud_firestore/cloud_firestore.dart';

class DbServices {
  // CATEGORIES
  // read  categories from database

  Stream<QuerySnapshot> readCategories() {
    return FirebaseFirestore.instance
        .collection("shop_categories")
        .orderBy("priority", descending: true)
        .snapshots();
  }

  // create new categories
  Future createCategories({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_categories").add(data);
  }

  // update categories
  Future updateCategories(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_categories")
        .doc(docId)
        .update(data);
  }

  // delete categories
  Future deleteCategories({required String docId}) async {
    await FirebaseFirestore.instance
        .collection("shop_categories")
        .doc(docId)
        .delete();
  }

  // PRODUCTS
  // read  products from database
  Stream<QuerySnapshot> readProducts() {
    return FirebaseFirestore.instance
        .collection("shop_products")
        // .orderBy("priority", descending: true)
        .snapshots();
  }

  // create new products
  Future createProducts({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_products").add(data);
  }

  // update products
  Future updateProducts(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_products")
        .doc(docId)
        .update(data);
  }

  // delete products
  Future deleteProducts({required String docId}) async {
    await FirebaseFirestore.instance
        .collection("shop_products")
        .doc(docId)
        .delete();
  }
}
