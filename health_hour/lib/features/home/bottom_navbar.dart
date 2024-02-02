import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_hour/constants/constants.dart';
import 'package:health_hour/features/home/home_page.dart';
import 'package:health_hour/features/home/settings_page.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav(this.user, {super.key});
  final User? user;
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
    final screens = [
      HomePage(widget.user),
      HomePage(widget.user),
      SettingsPage(),
    ];
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
              selectedItemColor: ProjectColors.primaryColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        
      ],
      currentIndex: _selectedIndex,
      onTap: (value) => _onItemTapped(value),),
    );
  }
}
