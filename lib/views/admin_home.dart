import 'package:ecommerce_admin_app/containers/dashboard_text.dart';
import 'package:ecommerce_admin_app/containers/home_buttons.dart';
import 'package:ecommerce_admin_app/controllers/auth_services.dart';
import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AdminProvider>(context, listen: false).cancelProvider();
                AuthServices().logOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 260,
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Consumer<AdminProvider>(builder: (context, value, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardText(
                      keyword: "Total Categories",
                      value: "${value.categories.length}"),
                  DashboardText(
                      keyword: "Total Products",
                      value: "${value.products.length}"),
                  DashboardText(
                      keyword: "Total Orders", value: "${value.totalOrders}"),
                  DashboardText(
                      keyword: "Ordered Not Shipped",
                      value: "${value.orderPendingProcess}"),
                  DashboardText(
                    keyword: "Ordered Shipped",
                    value: "${value.ordersOnTheWay}",
                  ),
                  DashboardText(
                      keyword: "Ordered Delivered",
                      value: "${value.ordersDelivered}"),
                  DashboardText(
                      keyword: "Ordered Cancelled",
                      value: "${value.ordersCancelled}"),
                ],
              );
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(
                  name: "Orders",
                  onPress: () {
                    Navigator.pushNamed(context, '/orders');
                  }),
              HomeButton(
                  name: "Products",
                  onPress: () {
                    Navigator.pushNamed(context, '/products');
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(
                  name: "Promos",
                  onPress: () {
                    Navigator.pushNamed(context, '/promo_banner',
                        arguments: {"promo": true});
                  }),
              HomeButton(
                  name: "Banners",
                  onPress: () {
                    Navigator.pushNamed(context, '/promo_banner',
                        arguments: {"promo": false});
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeButton(
                  name: "Categories",
                  onPress: () {
                    Navigator.pushNamed(context, '/categories');
                  }),
              HomeButton(
                  name: "Coupons",
                  onPress: () {
                    Navigator.pushNamed(context, '/coupons');
                  }),
            ],
          )
        ],
      ),
    );
  }

  // simple
}

class CheckUserLogInOrNot extends StatefulWidget {
  const CheckUserLogInOrNot({super.key});

  @override
  State<CheckUserLogInOrNot> createState() => _CheckUserLogInOrNotState();
}

class _CheckUserLogInOrNotState extends State<CheckUserLogInOrNot> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthServices().isLoggedIn().then((onValue) => {
          if (onValue)
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/adminHome', (route) => false)
            }
          else
            {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false)
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
