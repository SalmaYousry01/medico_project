import 'package:flutter/material.dart';
import 'package:grad_project/view_only_patient/prescription_view.dart';
import 'package:grad_project/view_only_patient/test_view.dart';
import '../Home_layout/family_history/family_history.dart';
import '../Home_layout/medicine/medicine_screen.dart';
import '../doctor_layout/all_patients/All_Patient.dart';
import 'allergy_view.dart';
import 'medicine_view.dart';

class ViewOnlyPatientView extends StatefulWidget {
  const ViewOnlyPatientView({Key? key}) : super(key: key);
  static const String routeName = 'viewonlypatientview';

  @override
  State<ViewOnlyPatientView> createState() => _hometaskState();
}

class _hometaskState extends State<ViewOnlyPatientView> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(152),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 180,
            leading: IconButton(
              onPressed: () {
                // FirebaseAuth.instance.signOut();
                // Navigator.pushNamed(context, PatientLogin.routeName);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllPatient()));
              },
              icon: Icon(Icons.arrow_back_outlined),
              color: Colors.black,
            ),
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
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Hi username",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(right: 40.0, bottom: 50, top: 50),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ProfileTab(),
                    //   ),
                    // );
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
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
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
                        width: 135,
                        height: 135,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrescriptionView(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage(
                                  "assets/images/prescreption.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrescriptionView())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Prescription',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
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
                        width: 135,
                        height: 135,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestView(),
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
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TestView())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Test',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
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
                                        AllergyView())); // navigator byn2l l page tanya
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
                          width: 135,
                          height: 135,
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
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllergyView())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Allergies',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FamilyHistory())); // navigator byn2l l page tanya
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
                          width: 135,
                          height: 135,
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
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
                          width: 135,
                          height: 135,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedicineView(),
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
                                        MedicineView())); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Medicine',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C698D)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
