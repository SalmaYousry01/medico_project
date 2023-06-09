import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/Allergies/allergy.dart';
import 'package:grad_project/Home_layout/patient_profile/profile.dart';
import 'package:grad_project/Home_layout/prescription/pateint_uploaded_prescriptions/patient_prescreption.dart';
import 'package:grad_project/Home_layout/prescription/prescription_navbar.dart';
import 'package:grad_project/Home_layout/test/test_screen.dart';
import 'package:grad_project/Home_layout/your_doctor/doctorlist.dart';
import 'family_history/familyhistory.dart';
import 'medicine/medicine_screen.dart';

class home extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<home> createState() => _hometaskState();
}

class _hometaskState extends State<home> {
  String? username = "";

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      //means if data exists
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()!["username"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(151),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 180,
            flexibleSpace: ClipRRect(
              child: Container(
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  "assets/images/Group 123.png",
                ))),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Hi " + username!,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 40.0, bottom: 50, top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileTab(),
                      ),
                    );
                  },
                  child: Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                        "assets/images/user.png",
                      )),
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 20),
          child: ListView(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(4, 4), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            color: Colors.white),
                        width: 142,
                        height: 142,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => lisett(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image:
                                    new AssetImage("assets/images/doctor.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        lisett())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Your Doctors',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(4, 4), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            color: Colors.white),
                        width: 142,
                        height: 142,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestScreen(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage("assets/images/test.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TestScreen())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Test',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedicineScreen())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      4, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                              color: Colors.white),
                          width: 142,
                          height: 142,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedicineScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage(
                                      "assets/images/medicine.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedicineScreen())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Medicine',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedicineScreen())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      4, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                              color: Colors.white),
                          width: 142,
                          height: 142,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FamilyHistory(),
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 24, top: 18),
                              child: Container(
                                decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        "assets/images/family.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FamilyHistory())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Family History',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset:
                                    Offset(4, 4), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(70)),
                            color: Colors.white),
                        width: 142,
                        height: 142,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Prescreption_navbar(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/prescreption.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PatientPrescription())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Prescription',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        allergy1())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(
                                      4, 4), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                              color: Colors.white),
                          width: 142,
                          height: 142,
                          child: Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                    "assets/images/allergies.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Allergies",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C698D)),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
