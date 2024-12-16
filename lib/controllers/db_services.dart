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

  //PROMOS & BANNERS
  //read promos from database
  Stream<QuerySnapshot> readPromos(bool isPromo) {
    return FirebaseFirestore.instance
        .collection(isPromo ? "shop_promos" : "shop_banners")
        .snapshots();
  }

  // CREATE NEW PROMO OR BANNER
  Future createPromos(
      {required Map<String, dynamic> data, required bool isPromo}) async {
    await FirebaseFirestore.instance
        .collection(isPromo ? "shop_promos" : "shop_banners")
        .add(data);
  }

  //UPDATE PROMOS OR BANNER
  Future updatePromos(
      {required Map<String, dynamic> data,
      required bool isPromo,
      required String docId}) async {
    await FirebaseFirestore.instance
        .collection(isPromo ? "shop_promos" : "shop_banners")
        .doc(docId)
        .update(data);
  }

  //DELETE PROMOS OR BANNER
  Future deletePromos({required bool isPromo, required String docId}) async {
    await FirebaseFirestore.instance
        .collection(isPromo ? "shop_promos" : "shop_banners")
        .doc(docId)
        .delete();
  }

  // DISCOUNT AND COUPON CODE
  //READ COUPON CODE FROM DATABASE
  Stream<QuerySnapshot> readCouponCode() {
    return FirebaseFirestore.instance.collection("shop_coupons").snapshots();
  }

  //CREATING  NEW COUPON CODE
  Future createCoupon({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_coupons").add(data);
  }

  //UPDATE COUPON CODE
  Future updateCoupon(
      {required Map<String, dynamic> data, required String docId}) async {
    await FirebaseFirestore.instance
        .collection("shop_coupons")
        .doc(docId)
        .update(data);
  }

  //DELETE COUPON CODE
  Future deleteCoupon({
    required String docId,
  }) async {
    await FirebaseFirestore.instance
        .collection("shop_coupons")
        .doc(docId)
        .delete();
  }
   // ORDERS
  // read all the orders
  Stream<QuerySnapshot> readOrders() {
    return FirebaseFirestore.instance
        .collection("shop_orders")
        .orderBy("created_at", descending: true)
        .snapshots();
  }

    // update the status of order
  Future updateOrderStatus(
      {required String docId, required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance
        .collection("shop_orders")
        .doc(docId)
        .update(data);
  }
}
