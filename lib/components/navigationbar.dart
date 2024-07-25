import 'package:chothuephongtro_v2/users/homepage.dart';
import 'package:chothuephongtro_v2/users/motels/lovedmotels.dart';
import 'package:chothuephongtro_v2/users/motels/motellist.dart';
import 'package:chothuephongtro_v2/users/profile/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          HomePage(),
          MotelList(),
          LovedMotels(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GNav(
        haptic: true, // haptic feedback
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(color: Colors.black, width: 0.5),
        duration: const Duration(milliseconds: 400),
        gap: 8,
        padding: const EdgeInsets.all(10),
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
        tabs: const [
          GButton(icon: Icons.home,text: 'Trang chủ',textColor: Colors.black, iconSize: 15),
          GButton(icon: Icons.hotel, text: 'Phòng trọ',textColor: Colors.black, iconSize: 15),
          GButton(icon: Icons.favorite_border, text: 'Yêu thích',textColor: Colors.black, iconSize: 15),
          GButton(icon: Icons.settings, text: 'Cài đặt',textColor: Colors.black, iconSize: 15),
        ],),
    );
  }
}
