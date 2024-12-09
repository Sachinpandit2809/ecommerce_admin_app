import 'package:ecommerce_admin_app/containers/dashboard_text.dart';
import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 235,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DashboardText(keyword: "total Product", value: "100"),
                DashboardText(keyword: "total Product", value: "100"),
                DashboardText(keyword: "total Product", value: "100"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(name: "Orders", onPress: () {}),
              HomeButton(name: "Products", onPress: () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(name: "Orders", onPress: () {}),
              HomeButton(name: "Products", onPress: () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(name: "Orders", onPress: () {}),
              HomeButton(name: "Products", onPress: () {}),
            ],
          )
        ],
      ),
    );
  }

  // simple 
}
