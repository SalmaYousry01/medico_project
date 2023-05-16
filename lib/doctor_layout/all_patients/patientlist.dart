// import 'package:flutter/material.dart';
// import 'All_Patient.dart';
//
// class lisetpatient extends StatefulWidget {
//   const lisetpatient({Key? key}) : super(key: key);
//   static const String routeName = 'lisetpatient';
//
//   @override
//   State<lisetpatient> createState() => _lisetpatientState();
// }
//
// class _lisetpatientState extends State<lisetpatient> {
//   //filter
//   int currentindex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomAppBar(
//         notchMargin: 8,
//         shape: CircularNotchedRectangle(),
//         child: BottomNavigationBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           currentIndex: currentindex,
//           onTap: (index) {
//             currentindex = index;
//             setState(() {});
//           },
//           items: [
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.people_alt_rounded,
//                   size: 30,
//                 ),
//                 label: 'All Patients'),
//           ],
//         ),
//       ),
//       body: tabs[currentindex],
//     );
//   }
//
//   List<Widget> tabs = [AllPatient()];
// }
