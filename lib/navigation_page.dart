import 'package:flutter/material.dart';
import 'package:platform_channel/pages/http_page.dart';
import 'package:platform_channel/pages/platform_channel_page.dart';
import 'package:platform_channel/pages/requests_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        PlatformChannelExample(),
        HttpPage(),
        RequestsPage(),
      ][currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPageIndex,
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          selectedLabelStyle: const TextStyle(color: Colors.black),
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.share), label: 'Method Channel'),
            BottomNavigationBarItem(
                icon: Icon(Icons.http), label: 'Networking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined), label: 'Requests')
          ]),
    );
  }
}
