import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_my_appartment/constant/constants.dart';
import 'package:share_my_appartment/tabcontrol/booking.dart';
import 'package:share_my_appartment/tabcontrol/homepage.dart';
import 'package:share_my_appartment/tabcontrol/my_account.dart';
import 'package:share_my_appartment/tabcontrol/shortlist.dart';
import 'package:share_my_appartment/utils/app_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class TabNavigation extends StatefulWidget {
  const TabNavigation({Key? key}) : super(key: key);

  @override
  State<TabNavigation> createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigation> {
  int _currentIndex = 0;
  DateTime preBackPressTime = DateTime.now();
  static const List<Widget> _pages = <Widget>[
    MyHomePage(),
    BookingPageListingPage(),
    ShortListingPage(),
    MyAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0XffEDEDEE),
    ));
    return WillPopScope(child: Scaffold(
      backgroundColor: const Color(0XffEDEDEE),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: kIsWeb ? 65 : Platform.isAndroid ? 65 : 95,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.zero,
          semanticContainer: true,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            backgroundColor: white,
            selectedItemColor: black,
            unselectedItemColor: dark_text,
            onTap: (value) {
              setState(() => _currentIndex = value);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Search',
                icon: Icon(Icons.search_rounded),
              ),
              BottomNavigationBarItem(
                  label: 'Bookings', icon: Icon(Icons.calendar_today_rounded)),
              BottomNavigationBarItem(
                label: 'Favourites',
                icon: Icon(Icons.favorite_border_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Account',
                icon: Icon(Icons.person_outline_rounded),
              ),
            ],
          ),
        ),
      ),
    ), onWillPop: () async {
      if(_currentIndex != 0)
      {
          setState(() {
            _currentIndex = 0;
          });
          return Future.value(false);
      }
      else
      {
        final timeGap = DateTime.now().difference(preBackPressTime);
        final cantExit = timeGap >= const Duration(seconds: 2);
        preBackPressTime = DateTime.now();
        if(cantExit){
          showSnackBar('Press back button again to exit', context);
          return Future.value(false);
        }else{
          SystemNavigator.pop();
          return Future.value(true);
        }
      }
    });
  }
}
