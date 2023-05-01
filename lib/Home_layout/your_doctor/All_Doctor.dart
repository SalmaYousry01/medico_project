import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grad_project/Home_layout/your_doctor/doctor_controller.dart';
import 'package:grad_project/Home_layout/your_doctor/modell.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_widget.dart';

class AllDoctor extends StatefulWidget {
  static const String routeName = 'AllDoctor';


  @override
  State<AllDoctor> createState() => _AllDoctorState();
}

class _AllDoctorState extends State<AllDoctor> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Color(0xFF2C698D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: Text('Doctors'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  showSearch<Doctor?>(
                      context: context, delegate: DoctorSearch());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: ListView.builder(
            itemCount: Doctor.doctors.length,
            itemBuilder: (context, index) {
              return SingleDoctortWidget(
                index: index,
                controller: DoctorController(),
                doctor: Doctor.doctors[index],
              );
            }));
  }
}

class DoctorSearch extends SearchDelegate<Doctor?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final listItems = query.isEmpty
        ? Doctor.doctors
        : Doctor.doctors
            .where((doctor) =>
                doctor.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return listItems.isEmpty
        ? const Center(
            child: Text("No Data Found !"),
          )
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return SingleDoctortWidget(
                index: index,
                controller: DoctorController(),
                doctor: listItems[index],
              );
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listItems = query.isEmpty
        ? Doctor.doctors
        : Doctor.doctors
            .where((doctor) =>
                doctor.name.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return listItems.isEmpty
        ? const Center(
            child: Text("No Doctor Found !"),
          )
        : ListView.builder(
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return SingleDoctortWidget(
                index: index,
                controller: DoctorController(),
                doctor: listItems[index],
              );
            });
  }
}
