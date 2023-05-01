import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/your_doctor/All_Doctor.dart';
import 'Your_doctor.dart';

class lisett extends StatefulWidget {
  const lisett({Key? key}) : super(key: key);
  static const String routeName = 'lisett';

  @override
  State<lisett> createState() => _lisettState();
}

class _lisettState extends State<lisett> {
  //filter
  int currentindex=0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),

        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: currentindex,
          onTap: (index){
            currentindex=index;
            setState(() {

            });
          },

          items: [
            BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded,size: 30,),label: 'All Doctor'),
            BottomNavigationBarItem(icon: Icon(Icons.person,size: 30,),label: 'My Doctors')
          ],),
      ),
      body: tabs[currentindex],


    );

  }
  List<Widget>tabs=[AllDoctor(),YourDoctors()];

}
