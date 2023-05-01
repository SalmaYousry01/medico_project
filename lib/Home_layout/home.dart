import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/prescription/patient_prescreption.dart';
import 'package:grad_project/Home_layout/test/test_screen.dart';
import 'package:grad_project/Home_layout/your_doctor/doctorlist.dart';
import '../login/patient_login.dart';
import 'medicine/medicine_screen.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);
  static const String routeName = 'home';

  @override
  State<home> createState() => _hometaskState();
}

class _hometaskState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(138),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 185,
            leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, PatientLogin.routeName);
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
              )
            ],
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 30, right: 20, left: 30, bottom: 20),
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
                                builder: (context) => PatientPrescription(),
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
                        child: Container(
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image:
                                  new AssetImage("assets/images/allergies.png"),
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
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
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
                        child: Container(
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage(
                                  "assets/images/medical info.png"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Measurments",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
