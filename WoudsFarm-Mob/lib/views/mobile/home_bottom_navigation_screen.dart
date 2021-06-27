import 'package:flutter/material.dart';
import 'package:wouds_farm/views/mobile/search/search_screen.dart';
import 'package:wouds_farm/views/mobile/wouds_farm/wouds_farm_screen.dart';

import '../../utils/app_colors.dart';
import 'account/account_screen.dart';
import 'cart/cart_screen.dart';

class HomeBottomNavigationScreen extends StatefulWidget {
  @override
  _HomeBottomNavigationScreenState createState() => _HomeBottomNavigationScreenState();
}

class _HomeBottomNavigationScreenState extends State<HomeBottomNavigationScreen> {
  final List<Widget> _children = [
    wouds_farmScreen(),
    SearchScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 8.0);
    return Scaffold(
      body: _children[selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 50.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: darkOrange,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          selectedLabelStyle: labelTextStyle,
          unselectedLabelStyle: labelTextStyle,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'wouds_farm',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'CART',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'ACCOUNT',
            ),
          ],
        ),
      ),
    );
  }
}
