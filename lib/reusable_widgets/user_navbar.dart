import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/discovery_screen.dart';
import '../screens/login/login_page.dart';
import '../screens/wishlist_screen.dart';
import '../screens/writter_buttons_screens/profile_screen.dart';

class UserNavBar extends StatelessWidget {
  UserNavBar({
    super.key,
  });

  final tabBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), label: "Discover"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.book), label: "Wishlist"),
    const BottomNavigationBarItem(icon: Icon(Icons.list), label: "Profile")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: tabBarItems,
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const DiscoveryScreen();

            case 1:
              return WishlistScreen();

            case 2:
              return const ProfileScreen();
          }

          return const LoginPage();
        },
      ),
    );
  }
}
