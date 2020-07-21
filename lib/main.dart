import 'package:asuser/apis/providers.dart/product_provider.dart';
import 'package:asuser/locator.dart';
import 'package:asuser/screens/add_product.dart';
import 'package:asuser/screens/auth_page.dart';
import 'package:asuser/screens/landing_page.dart';
import 'package:asuser/screens/spash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupProductLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) {
            return ProductProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {'/zufiyacode': (context) => AddProductPage()},
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              // if (userSnapshot.hasData) {
              return LandingPage();
              // }
              // return AuthPage();
            }),
      ),
    );
  }
}
