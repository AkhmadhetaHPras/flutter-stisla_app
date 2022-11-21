import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stisla_app/components/build_page.dart';
import 'package:stisla_app/components/loader.dart';
import 'package:stisla_app/components/logout_page.dart';
import 'package:stisla_app/models/category.dart';
import 'package:stisla_app/page/category/list.dart';
import 'package:stisla_app/services/categoryservices.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Category> categories = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getAll();
  }

  void getAll() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    if (token != null) {
      var response = await CategoryServices.getAll(token);
      setState(() {
        _isLoading = false;
      });
      var listcategory = json.decode(response.body);
      for (var element in listcategory['data']) {
        print(element);
        var category = Category(id: element['id'], name: element['name']);
        categories.add(category);
      }
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: <Widget>[
            const LogoutPage(),
            !_isLoading ? CategoryList(categories: categories) : const Loader(),
            BuildPage(
              icon: Icons.menu,
              title: 'Menu',
              color: Colors.pink,
            ),
            BuildPage(
              icon: Icons.settings,
              title: 'Settings',
              color: Colors.purpleAccent,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.people),
                title: const Text('Users'),
                activeColor: Colors.greenAccent),
            BottomNavyBarItem(
              icon: const Icon(Icons.category),
              title: const Text('Category'),
              activeColor: Colors.orangeAccent,
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.menu),
                title: const Text('Menu'),
                activeColor: Colors.pink),
            BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                activeColor: Colors.purpleAccent),
          ],
        ));
  }
}
