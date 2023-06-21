import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:grad_project/create_account/patient_signup.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = 'ProfileTab';

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var Mobilenumbercontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var agecontroller = TextEditingController();
  var bloodsugarcontroller = TextEditingController();
  var bloodpressurecontroller = TextEditingController();
  var heartcontroller = TextEditingController();
  var kidneycontroller = TextEditingController();
  var livercontroller = TextEditingController();
  var bloodcontroller = TextEditingController();
  var surgerycontroller = TextEditingController();
  var measurementsData;
  String? phonenumber = "";
  String? newnumber = "";
  String? email = "";
  String? age = "";
  String? newage = "";
  String? username = "";
  String? usernameupdate = "";
  String? blood_sugar = "";
  String? new_blood_sugar = "";
  String? blood_pressure = "";
  String? new_blood_pressure = "";
  String? heart = "";
  String? newheart = "";
  String? kidney = "";
  String? newkidney = "";
  String? liver = "";
  String? newliver = "";
  String? blood_type = "";
  String? new_blood_type = "";
  String? surgery = "";
  String? new_surgery = "";
  final imagepicker = ImagePicker();
  String? image = "";
  File? imageXFile;
  String? imageurl;

  Future<void> _getDataFromDatabase() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }
    final snapshot = await FirebaseFirestore.instance
        .collection("Patients")
        .doc(currentUser.uid)
        .get();
    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null) {
        setState(() {
          email = data["email"];
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
          surgery = data["surgery"];
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
  }

  Future _updatephone() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"phonenumber": newnumber});
  }

  Future _updateage() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"age": newage});
  }

  Future _updateusername() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"username": usernameupdate});
  }

  Future _updateheart() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"heart": newheart});
  }

  Future _updatebloodtype() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"blood_type": new_blood_type});
  }

  Future _updatekidney() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"kidney": newkidney});
  }

  Future _updateliver() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"liver": newliver});
  }

  Future _updatebloodpressure() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"blood_pressure": new_blood_pressure});
  }

  Future _updatebloodsugar() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"blood_sugar": new_blood_sugar});
  }


  Future _updatesurgery() async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"surgery": new_surgery});
  }

  _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("type here"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  usernameupdate = value;
                });
              },
              decoration: InputDecoration(hintText: "type your new username"),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _updateusername();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => ProfileTab()));
                    });
                  },
                  child: Text("Save")),
            ],
          );
        });
  }

  void getfromcamera() async {
    final pickedimage = await imagepicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageXFile = File(pickedimage!.path);
      updateimageinfirestore();
    });

    Navigator.pop(this.context);
  }

  void getfromgallery() async {
    final pickedimage =
    await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile = File(pickedimage!.path);
      updateimageinfirestore();
    });
    // XFile?pickedimage =await imagepicker.pickImage(source: ImageSource.gallery);

    Navigator.pop(this.context);
  }

  void showimage() {
    showDialog(
        context: this.context,
        builder: (context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text("Please choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    getfromcamera();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                      ),
                      Text(
                        " Camera",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    getfromgallery();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text(
                        " Gallery",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void updateimageinfirestore() async {
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    fstorage.Reference reference = fstorage.FirebaseStorage.instance
        .ref()
        .child("Patients/Patient Profile")
        .child(filename);

    fstorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
    fstorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      imageurl = url;
    });

    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"image": imageurl});
    // image url will contain the downloaded pic
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
          child: Column(children: [
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
                          onTap: showimage,
                          child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              minRadius: 90,
                              backgroundImage: imageXFile == null
                                  ? NetworkImage(image!) //already used image
                                  : Image.file(imageXFile!).image //updated one,

                          ),
                        )),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "" + username!,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  IconButton(
                      onPressed: () {
                        _displayTextInputDialog(context);
                      },
                      icon: Icon(Icons.edit)),

                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 5, left: 55, right: 55),
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email Address",
                            style: TextStyle(color: Color(0xFF22C698D)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              //disabledBorder: ,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF22C698D),
                                    )),
                                hintText: ("" + email!),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF22C698D),
                                ),
                                border: OutlineInputBorder()),
                          ),
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
                            onChanged: (value) {
                              setState(() {
                                newnumber = value;
                              });
                            },
                            controller: Mobilenumbercontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF22C698D),
                                    )),
                                hintText: ("" + phonenumber!),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                prefixIcon:
                                Icon(Icons.phone, color: Color(0xFF22C698D)),
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
                          TextFormField(
                            controller: agecontroller,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                newage = value;
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF22C698D),
                                    )),
                                hintText: ("" + age!),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/agee.png'),
                                    size: 5,
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder()),
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
                          TextFormField(
                            controller: bloodcontroller,

                            onChanged: (value) {
                              setState(() {
                                new_blood_type = value;
                              });
                            },
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
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder()),
                          ),
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
                            onChanged: (value) {
                              setState(() {
                                new_blood_pressure = value;
                              });
                            },
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
                                  AssetImage('assets/images/blood-pressure.png'),

                                  color: Color(0xFF2C698D),
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),),
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
                            onChanged: (value) {
                              setState(() {
                                new_blood_sugar = value;
                              });
                            },
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
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),),

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
                            controller: surgerycontroller,
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
                                hintText: ("" + surgery!),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/surgery.png'),
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(height: 10,),
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
                            onChanged: (value) {
                              setState(() {
                                newheart = value;
                              });
                            },
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
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
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
                            onChanged: (value) {
                              setState(() {
                                newkidney = value;
                              });
                            },
                            controller: kidneycontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF22C698D),
                                    )),
                                hintText: ("" + kidney!),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/kidneys.png'),
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder()),
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
                            onChanged: (value) {
                              setState(() {
                                liver = value;
                              });
                            },
                            controller: livercontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF22C698D),
                                    )),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ImageIcon(
                                    AssetImage('assets/images/liver.png'),
                                    size: 5,
                                    color: Color(0xFF2C698D),
                                  ),
                                ),
                                hintText: ("" + liver!),
                                suffixIcon: GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder()),
                          ),
                        ]))),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color(0xFF22C698D))),
                  onPressed: () {
                    setState(() {
                      _updatephone();
                      _updateage();
                      _updatebloodtype();
                      _updatebloodpressure();
                      _updatebloodsugar();
                      _updateheart();
                      _updatekidney();
                      _updateliver();
                    });
                  },
                  child: Text("SAVE")),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 8),
              child: Container(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => PatientSignup()));
                  },
                  child: Image.asset("assets/images/signout.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 290.0, bottom: 5),
              child: Text(
                'Sign Out',
                textAlign: TextAlign.right,
              ),
            ),
          ]),
        ));
  }
}
