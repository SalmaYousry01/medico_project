import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:grad_project/models/my_doctor.dart';
import 'package:grad_project/models/my_patient.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  static const String routeName = 'ProfileTab';

  String? patientId;

  ProfileView([this.patientId]);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var Mobilenumbercontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var agecontroller = TextEditingController();
  var bloodsugarcontroller = TextEditingController();
  var bloodpressurecontroller = TextEditingController();
  var heartcontroller = TextEditingController();
  var kidneycontroller = TextEditingController();
  var livercontroller = TextEditingController();
  var bloodcontroller = TextEditingController();

  String? phonenumber = "";
  String? age = "";
  String? username = "";
  String? blood_sugar = "";
  String? blood_pressure = "";
  String? heart = "";
  String? kidney = "";
  String? liver = "";
  String? blood_type = "";
  final imagepicker = ImagePicker();
  String? image = "";
  File? imageXFile;
  String? imageurl;

  // Future<void> _getDataFromDatabase() async {
  //   final currentUser = FirebaseAuth.instance.currentUser;
  //   if (currentUser == null) {
  //     return;
  //   }
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection(DoctorDataBase.COLLECTION_NAME)
  //       .doc(currentUser.uid)
  //       .collection(MyPatient.COLLECTION_NAME)
  //       .doc(currentUser.uid)
  //       .get();
  //   if (snapshot.exists) {
  //     final data = snapshot.data();
  //     if (data != null) {
  //       setState(() {
  //         phonenumber = data["phonenumber"];
  //         username = data["username"];
  //         image = data["image"];
  //         age = data["age"];
  //         blood_type = data["blood_type"];
  //         blood_pressure = data["blood_pressure"];
  //         blood_sugar = data["blood_sugar"];
  //         heart = data["heart"];
  //         kidney = data["kidney"];
  //         liver = data["liver"];
  //       });
  //     }
  //   }
  // }

  Future<void> _getDataFromDatabase() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }
    final snapshot = await FirebaseFirestore.instance
        .collection(DoctorDataBase.COLLECTION_NAME)
        .doc(currentUser.uid)
        .collection(MyPatient.COLLECTION_NAME)
        .get();
    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            phonenumber = data["phonenumber"];

            username = data["username"];
            image = data["image"];
            age = data["age"];
            blood_type = data["blood_type"];
            blood_pressure = data["blood_pressure"];
            blood_sugar = data["blood_sugar"];
            heart = data["heart"];
            kidney = data["kidney"];
            liver = data["liver"];
          });
        }
      }
    }
  }

  Stream<QuerySnapshot<MyPatient>>? myEditPatientStream;

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: AppBar(
            backgroundColor: (Colors.white),
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => home()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: myEditPatientStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF22C698D),
                        borderRadius: BorderRadius.circular(15)),
                    width: 377,
                    height: 125,
                    margin: EdgeInsets.only(top: 20, left: 10, right: 9),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 13.0, right: 8),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(60)),
                              width: 80,
                              height: 80,
                              child: GestureDetector(
                                child: CircleAvatar(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.9),
                                    minRadius: 90,
                                    backgroundImage: imageXFile == null
                                        ? NetworkImage(
                                            image!) //already used image
                                        : Image.file(imageXFile!)
                                            .image //updated one,

                                    ),
                              )),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Text(
                          "" + username!,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 5, left: 55, right: 55),
                      child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Phone number",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: Mobilenumbercontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xFF22C698D),
                                  )),
                                  hintText: ("" + phonenumber!),
                                  prefixIcon: Icon(Icons.phone,
                                      color: Color(0xFF22C698D)),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Age",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // FutureBuilder<QuerySnapshot<MyPatient>>(
                            //   future: DatabaseUtilsdoctor.getEditPatient(widget.patientId!),
                            //   builder: (context, snapshot) {
                            //  if (snapshot.hasData) {
                            //    final age = snapshot.data!.docs.first.get('age') ;
                            TextFormField(
                              controller: agecontroller,
                              keyboardType: TextInputType.number,
                              // initialValue: age(),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF22C698D),
                                  ),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/agee.png'),
                                    size: 5,
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Blood Type",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            // StreamBuilder(
                            //     stream: myEditPatientStream,
                            //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            //       if (snapshot.hasData) {
                            //         final blood_type = snapshot.data!.docs[0]['blood_type'];
                            TextFormField(
                              controller: bloodcontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xFF22C698D),
                                  )),
                                  hintText: ("" + blood_type!),
                                  prefixIcon: Icon(
                                    Icons.bloodtype,
                                    color: Color(0xFF22C698D),
                                    size: 26,
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                            //       }
                            //     else {
                            //       return Text("error");}
                            //     }
                            //
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Pressure",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: bloodpressurecontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF22C698D),
                                )),
                                hintText: ("" + blood_pressure!),
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: ImageIcon(
                                    AssetImage(
                                        'assets/images/blood-pressure.png'),
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Blood Sugar",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: bloodsugarcontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF22C698D),
                                )),
                                hintText: ("" + blood_sugar!),
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/sugar.png'),
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Previous Surgeries",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              //controller: surgerycontroller,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  //  new_surgery = value;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF22C698D),
                                )),
                                // hintText: ("" + surgery!),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/surgery.png'),
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Heart",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: heartcontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xFF22C698D),
                                  )),
                                  hintText: ("" + heart!),
                                  prefixIcon: Icon(
                                    Icons.monitor_heart,
                                    color: Color(0xFF22C698D),
                                  ),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Kidney",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: kidneycontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF22C698D),
                                )),
                                hintText: ("" + kidney!),
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/kidneys.png'),
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Liver",
                              style: TextStyle(color: Color(0xFF22C698D)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: livercontroller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color(0xFF22C698D),
                                )),
                                hintText: ("" + liver!),
                                border: OutlineInputBorder(),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/liver.png'),
                                    size: 5,
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                              ),
                            ),
                          ]))),
                  SizedBox(
                    height: 10,
                  ),
                ]);
              }),
        ));
  }
}
