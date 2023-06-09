import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import 'package:grad_project/view_only_patient/familyHistory_view/familyhistory_container.dart';

import '../../Home_layout/family_history/familyhistory.items.dart';
import '../../models/my_family.dart';
import '../view_only_patient_view.dart';

class FamilyhistoryView extends StatefulWidget {
  @override
  State<FamilyhistoryView> createState() => FamilyhistoryViewState();
  static const String routeName = 'familyhistoryView';

  String? patientId;

  FamilyhistoryView([this.patientId]);
}

class FamilyhistoryViewState extends State<FamilyhistoryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 35),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewOnlyPatientView(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 28,
                    ),
                  ),
                  Text(
                    "Family History",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C698D)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Color(0xFF216B98),
            height: 37,
          ),
          Expanded(
            flex: 8,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: FutureBuilder<QuerySnapshot<MyFamilyhistory>>(
                  future: DatabaseUtilsdoctor.getPatientFamilyHistory(
                      widget.patientId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('something went wrong'));
                    }
                    var familyhistory = snapshot.data?.docs
                            .map((docs) => docs.data())
                            .toList() ??
                        [];
                    if (familyhistory.isEmpty) {
                      return const Center(
                        child: Text(
                          "There is no family history yet",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF2C698D)),
                        ),
                      );
                    }
                    return ListView.builder(
                        itemCount: familyhistory.length,
                        itemBuilder: (context, Index) {
                          return FamilyhistoryContainer(familyhistory[Index]);
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFamilyhistorye() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      child: new ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.5),
            child: new Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  deleteddetails = details[index];
                  deleteddegree = degree[index];
                  details.removeAt(index);
                  degree.removeAt(index);
                });
              },
              child: familyhistoryList(index),
            ),
          );
        },
      ),
    );
  }

  Widget familyhistoryList(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 70,
        child: Center(
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: ListTile(
                          title: Text(
                            details[index],
                            style: TextStyle(
                              fontSize: 20.00,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            degree[index],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
