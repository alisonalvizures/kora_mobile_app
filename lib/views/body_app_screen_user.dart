import 'package:flutter/material.dart';
import 'package:kora_app/views/list_blog_screen.dart';
import 'package:kora_app/views/list_chats_screen.dart';
import 'package:kora_app/views/list_settings_screen.dart';
import 'package:kora_app/views/list_tracking_screen.dart';
import 'package:kora_app/views/list_volunteers_screen.dart';
import 'colors.dart';

class BodyAppUserScreen extends StatefulWidget {
  const BodyAppUserScreen({super.key});

  @override
  State<BodyAppUserScreen> createState() => _BodyAppUserScreenState();
}

class _BodyAppUserScreenState extends State<BodyAppUserScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    ListVolunterScreen(),
    ListBlogScreen(),
    ListChatScreen(),
    ListTrackingScreen(),
    ListSettingScreen(),
  ];



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: lightbackground[500],
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkpurple[500],
        elevation: 1,
        selectedItemColor: darkpurple[500],
        unselectedItemColor: lightpurple[500],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_contact_cal),
            label: 'Voluntarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces_rounded),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}