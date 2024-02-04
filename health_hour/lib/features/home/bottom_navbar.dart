import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/auhtenticate/signin/signin_page.dart';
import 'package:health_hour/features/home/home_page.dart';
import 'package:health_hour/features/home/settings_page.dart';
import 'package:health_hour/features/notification/notification.dart';

class BottomNav extends ConsumerStatefulWidget {
   const BottomNav({super.key, required this.user,  });
  final User? user;
  // Map<String, dynamic> ? userData;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     final userData = getUserData(widget.user?.uid);
     print(userData.toString());

    final screens = [
      HomePage(widget.user),
      const NotificationsPage(),
      const SettingsPage(),
    ];

      final doctorScreens = [
      HomePage(widget.user),
     
      const SettingsPage(),
    ];
    const screenItems = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        
      ];
          const doctorScreenItems = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')];
        
    return Scaffold(
      body:  screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
              selectedItemColor: ProjectColors.primaryColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
        items:screenItems,
      currentIndex: _selectedIndex,
      onTap: (value) => _onItemTapped(value),),
    );
  }
}
