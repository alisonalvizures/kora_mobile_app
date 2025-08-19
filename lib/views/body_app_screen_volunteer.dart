import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:kora_app/views/list_blog_screen.dart';
import 'package:kora_app/views/list_chats_screen.dart';
import 'package:kora_app/views/list_settings_screen.dart';
import 'colors.dart';

class BodyAppScreenVolunteer extends StatefulWidget {
  const BodyAppScreenVolunteer({super.key});

  @override
  State<BodyAppScreenVolunteer> createState() => _BodyAppScreenVolunteerState();
}

class _BodyAppScreenVolunteerState extends State<BodyAppScreenVolunteer> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

  }

  static const List<Widget> _pages = <Widget>[
    ListBlogScreen(),
    ListChatScreen(),
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
        backgroundColor: Colors.white,
        elevation: 1,
        selectedItemColor: darkpurple[500],
        unselectedItemColor: lightpurple[500],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
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