import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import '../../user_interface/main_pages/liked.dart';
import '../../user_interface/main_pages/home.dart';
import '../../user_interface/main_pages/discover.dart';
import 'settings_animation_controller.dart';
import '../../user_interface/main_pages/traveling_reels/reels_main.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int currentIndex = 0;
  int prevIndex = 0;
  bool isReversed = false;
  List pages = [
    HomeScreen(),
    Plan(),
    //Reels(),
    WishListPage(),
  ];

  bool getReverseStatus() {
    return isReversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        showElevation: false,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            prevIndex = currentIndex;
            currentIndex = index;
            if (prevIndex > currentIndex) {
              isReversed = true;
              Functions.instance.setReverseStatus(isReversed);
            } else {
              isReversed = false;
              Functions.instance.setReverseStatus(isReversed);
            }
            // print('currentIndex : $currentIndex & prevIndex : $prevIndex & isReversed : $isReversed');
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            //icon: Icon(AntDesign.hearto),
            icon: Icon(CupertinoIcons.compass),
            title: Text(
              'Track',
              textScaleFactor: 1.0,
            ),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Color.fromRGBO(99, 99, 99, 1),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.map),
            title: Text(
              'Discover',
              textScaleFactor: 1.0,
            ),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Color.fromRGBO(99, 99, 99, 1),
          ),
          /* BottomNavyBarItem(
            icon: Icon(CupertinoIcons.film),
            title: Text(
              'Reels',
              textScaleFactor: 1.0,
            ),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Color.fromRGBO(99, 99, 99, 1),
          ), */
          BottomNavyBarItem(
            icon: Icon(CupertinoIcons.heart_solid),
            title: Text(
              'Bucket List',
              textScaleFactor: 1.0,
            ),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Color.fromRGBO(99, 99, 99, 1),
          ),
        ],
      ),
    );
  }
}
