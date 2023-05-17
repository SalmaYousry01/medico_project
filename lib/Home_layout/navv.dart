import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/notes/note_page.dart';
import 'package:grad_project/Home_layout/patient_profile/profile.dart';
import 'package:grad_project/Home_layout/reminder/reminder.dart';
import 'home.dart';

class navv extends StatefulWidget {
  const navv({super.key});

  //first page after signing in
  static const String routeName = 'navv';

  @override
  State<navv> createState() => _navvState();
}

class _navvState extends State<navv> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[];
  List pages = [
    home(),
    reminder1(),
    NotesPage(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/home.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/cal.png'),
            ),
            label: 'Riminder',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/note.png'),
            ),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/profile.png'),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF2C698D),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
