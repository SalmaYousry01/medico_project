import 'package:flutter/material.dart';
import 'package:grad_project/view_only_patient/patient_profile.dart';
import 'package:grad_project/view_only_patient/prescription_view/prescription_view/prescription_view.dart';
import 'package:grad_project/view_only_patient/prescription_view/prescription_view_navbar.dart';
import 'package:grad_project/view_only_patient/test_view/test_view.dart';
import '../Home_layout/medicine/medicine_screen.dart';
import '../doctor_layout/all_patients/All_Patient.dart';
import '../models/my_patient.dart';
import 'allergy_view/allergy_view.dart';
import 'familyHistory_view/familyhistory_view.dart';
import 'medicine_view/medicine_view.dart';

class ViewOnlyPatientView extends StatefulWidget {
  static const String routeName = 'viewonlypatientview';

  MyPatient? patient;

  ViewOnlyPatientView({this.patient});

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
            // leading: IconButton(
            //   onPressed: () {
            //     // FirebaseAuth.instance.signOut();
            //     // Navigator.pushNamed(context, PatientLogin.routeName);
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => AllPatient()));
            //   },
            //   icon: Icon(Icons.arrow_back_outlined),
            //   color: Colors.black,
            // ),
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
                    const EdgeInsets.only(right: 40.0, bottom: 50, top: 20),
                child: GestureDetector(
                  onTap: (() {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileView(widget.patient!
                                  .id))); // navigator byn2l l page tanya
                    });
                  }),
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
                                builder: (context) => PrescriptionViewNavbar(),
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
                                    builder: (context) => PrescriptionView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                                builder: (context) =>
                                    TestView(widget.patient!.id),
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
                                    builder: (context) => TestView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                                    builder: (context) => AllergyView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                                    builder: (context) => AllergyView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                                    builder: (context) => FamilyhistoryView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24, top: 18),
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
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FamilyhistoryView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                                  builder: (context) =>
                                      MedicineView(widget.patient!.id),
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
                                    builder: (context) => MedicineView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
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
                                builder: (context) =>
                                    PrescriptionView(widget.patient!.id),
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
                                    builder: (context) => PrescriptionView(widget
                                        .patient!
                                        .id))); // navigator byn2l l page tanya
                          });
                        }),
                        child: Text(
                          'Prescription View',
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // Column(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 3,
                  //               blurRadius: 7,
                  //               offset:
                  //                   Offset(4, 4), // changes position of shadow
                  //             ),
                  //           ],
                  //           borderRadius: BorderRadius.all(Radius.circular(70)),
                  //           color: Colors.white),
                  //       width: 135,
                  //       height: 135,
                  //       child: InkWell(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) =>
                  //                   PrescListPage(myPrescriptionStream: myPrescriptionStream),
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           decoration: new BoxDecoration(
                  //             image: new DecorationImage(
                  //               image: new AssetImage(
                  //                 "assets/images/prescreption.png",
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     TextButton(
                  //       onPressed: (() {
                  //         setState(() {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) =>
                  //                       DoctorUploadedPrescription(widget
                  //                           .patient!
                  //                           .id))); // navigator byn2l l page tanya
                  //         });
                  //       }),
                  //       child: Text(
                  //         'Exported Prescriptions',
                  //         style: TextStyle(
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold,
                  //             color: Color(0xFF2C698D)),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
