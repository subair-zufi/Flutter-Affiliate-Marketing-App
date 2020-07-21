import 'package:asuser/screens/all_products_page.dart';
import 'package:asuser/screens/categories_page.dart';
import 'package:asuser/screens/home_page.dart';
import 'package:asuser/screens/stores_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      final fbm = FirebaseMessaging();
      fbm.requestNotificationPermissions();
      fbm.configure(onMessage: (msg) {
        print(msg);
        return;
      }, onLaunch: (msg) {
        print(msg);
        return;
      }, onResume: (msg) {
        print(msg);
        return;
      });
      fbm.subscribeToTopic('user');
    }
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    StoresPage(),
    CategoriesPage(),
    AllProductsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    var appTitle;
    if (_currentIndex == 0)
      appTitle = 'Hot Offers';
    else if (_currentIndex == 1)
      appTitle = 'Stores';
    else if (_currentIndex == 2)
      appTitle = 'Categories';
    else if (_currentIndex == 3)
      appTitle = 'Search';
    else
      appTitle = 'Offer Zone';

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Hot'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Stores'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Categories'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          )
        ],
      ),
    );
  }
}
