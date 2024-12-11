import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  List<QueryDocumentSnapshot> categories = [];
  StreamSubscription<QuerySnapshot>? _categoriesSubscription;
  int totalCategories = 0;
  AdminProvider() {
    getCategories();
    getProducts();
  }

  // GET all the categories
  void getCategories() {
    _categoriesSubscription?.cancel();
    _categoriesSubscription = DbServices().readCategories().listen((snapshot) {
      categories = snapshot.docs;
      totalCategories = snapshot.docs.length;
      notifyListeners();
    });
  }

  List<QueryDocumentSnapshot> products = [];
  StreamSubscription<QuerySnapshot>? _productsSubscription;
  int totalProducts = 0;

  // GET all the Products
  void getProducts() {
    _productsSubscription?.cancel();
    _productsSubscription = DbServices().readProducts().listen((snapshot) {
      products = snapshot.docs;
      totalProducts = snapshot.docs.length;
      notifyListeners();
    });
  }
}
