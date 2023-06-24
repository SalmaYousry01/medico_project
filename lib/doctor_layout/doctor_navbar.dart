import 'package:flutter/material.dart';
import 'package:grad_project/doctor_layout/all_patients/All_Patient.dart';
import '../Profile/clinicProfile.dart';

class navdoc extends StatefulWidget {
  const navdoc({super.key});

  //first page after signing in
  static const String routeName = 'navdoc';

  @override
  State<navdoc> createState() => _navdocState();
}

class _navdocState extends State<navdoc> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[];
  List pages = [ClinicProfile(true), AllPatient()];

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
              AssetImage('assets/images/profile.png'),
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outline_sharp,
              color: Color(0xFF2C698D),
            ),
            label: 'All Patients',
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
