import 'package:ecommerce_admin_app/providers/admin_provider.dart';
import 'package:ecommerce_admin_app/views/admin_home.dart';
import 'package:ecommerce_admin_app/views/categories_page.dart';
import 'package:ecommerce_admin_app/views/auth/login.dart';
import 'package:ecommerce_admin_app/views/coupons/coupons_page.dart';
import 'package:ecommerce_admin_app/views/products/modify_product_page.dart';
import 'package:ecommerce_admin_app/views/products/products_page.dart';
import 'package:ecommerce_admin_app/views/auth/signin.dart';
import 'package:ecommerce_admin_app/views/promos_banners/modify_promo_banner.dart';
import 'package:ecommerce_admin_app/views/promos_banners/promo_banners_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: MaterialApp(
        title: 'Ecommerce Admin App',
        theme: ThemeData(
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => CheckUserLogInOrNot(),
          '/adminHome': (context) => AdminHome(),
          '/login': (context) => LoginPage(),
          '/signin': (context) => SignIn(),
          '/checkUser': (context) => CheckUserLogInOrNot(),
          '/categories': (context) => CategoriesPage(),
          '/products': (context) => ProductsPage(),
          '/add_products': (context) => ModifyProductPage(),
          '/promo_banner': (context) => PromoBannersPage(),
          '/modify_promo_banner': (context) => ModifyPromoBanner(),
          '/coupons': (context) => CouponsPage(),
        },
      ),
    );
  }
}
