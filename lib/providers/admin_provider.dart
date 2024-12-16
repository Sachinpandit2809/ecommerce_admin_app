import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_app/controllers/db_services.dart';
import 'package:flutter/material.dart';

class AdminProvider with ChangeNotifier {
  List<QueryDocumentSnapshot> categories = [];
  StreamSubscription<QuerySnapshot>? _categoriesSubscription;
  List<QueryDocumentSnapshot> products = [];
  StreamSubscription<QuerySnapshot>? _productsSubscription;
  List<QueryDocumentSnapshot> orders = [];
  StreamSubscription<QuerySnapshot>? _ordersSubscription;

  int totalProducts = 0;
  int totalCategories = 0;
  //
  int totalOrders = 0;
  int ordersDelivered = 0;
  int ordersCancelled = 0;
  int ordersOnTheWay = 0;
  int orderPendingProcess = 0;

  AdminProvider() {
    getCategories();
    getProducts();
    readOrders();
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

  // GET all the Products
  void getProducts() {
    _productsSubscription?.cancel();
    _productsSubscription = DbServices().readProducts().listen((snapshot) {
      products = snapshot.docs;
      totalProducts = snapshot.docs.length;
      notifyListeners();
    });
  }

  // read all the orders
  void readOrders() {
    _ordersSubscription?.cancel();
    _ordersSubscription = DbServices().readOrders().listen((snapshot) {
      orders = snapshot.docs;
      debugPrint(orders.toString());

      totalOrders = snapshot.docs.length;
      setOrderStatusCount();
      notifyListeners();
    });
  }

  // to the various order types
  void setOrderStatusCount() {
    ordersDelivered = 0;
    ordersCancelled = 0;
    ordersOnTheWay = 0;
    orderPendingProcess = 0;
    for (int i = 0; i < orders.length; i++) {
      if (orders[i]["status"] == "DELIVERED") {
        ordersDelivered++;
      } else if (orders[i]["status"] == "CANCELLED") {
        ordersCancelled++;
      } else if (orders[i]["status"] == "ON_THE_WAY") {
        ordersOnTheWay++;
      } else {
        orderPendingProcess++;
      }
    }
    notifyListeners();
  }

  void cancelProvider() {
    _ordersSubscription?.cancel();
    _productsSubscription?.cancel();
    _categoriesSubscription?.cancel();
  }

  @override
  void dispose() {
    cancelProvider();
    super.dispose();
  }
}
