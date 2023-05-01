import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:grad_project/Home_layout/patient_profile/qr.dart';
import 'package:grad_project/create_account/patient_signup.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = 'ProfileTab';


  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  var phonecontroller =TextEditingController();
  var emailcontroller =TextEditingController();
  var agecontroller =TextEditingController();
  String? phonenumber="";
  String?newnumber;
  String? email="";
  String?age;
  String?newage;
  String? username="";
  String? usernameupdate="";
  final imagepicker =ImagePicker();
  String? image="";
  File? imageXFile;
  String?imageurl;


  Future _getDataFromDatabase() async{
    await FirebaseFirestore.instance.collection("Patients")

        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      //means if data exists
      if(snapshot.exists){
        setState(() {
          email= snapshot.data()!["email"];
          phonenumber= snapshot.data()!["phonenumber"];
          username= snapshot.data()!["username"];
          image= snapshot.data()!["image"];

        });
      }
    });
  }


  @override
  void initState(){
    super.initState();
    _getDataFromDatabase();
  }

  Future _updatephone() async
  {
    await FirebaseFirestore.instance.collection("Patients").
    doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "phonenumber": newnumber
    });
  }


  Future _updateage() async
  {
    await FirebaseFirestore.instance.collection("Patients").
    doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "age": newage
    });
  }

  Future _updateusername() async
  {
    await FirebaseFirestore.instance.collection("Patients").
    doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "username": usernameupdate
    });
  }
  _displayTextInputDialog(BuildContext context)async
  {
    return showDialog(
        context: context, builder: (context)
    {
      return AlertDialog(
        title: Text("type here"),
        content: TextField(
          onChanged: (value){
            setState(() {
              usernameupdate = value;
            });},
          decoration: InputDecoration(hintText: "type your new username"),
        ),
        actions: [

          ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.pop(context);
                });
              }, child: Text("Cancel")),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  _updateusername();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ProfileTab()));
                });
              }, child: Text("Save")),
        ],
      );
    });
  }



  void getfromcamera()async{

    final pickedimage =await imagepicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageXFile=File(pickedimage!.path);
      updateimageinfirestore();
    });

    // XFile?pickedimage =await imagepicker.pickImage(source: ImageSource.camera);
    // imageXFile=File(pickedimage!.path);
    Navigator.pop(this.context);
  }

  void getfromgallery()async{
    final pickedimage =await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile=File(pickedimage!.path);
      updateimageinfirestore();
    });
    // XFile?pickedimage =await imagepicker.pickImage(source: ImageSource.gallery);

    Navigator.pop(this.context);
  }

  void showimage(){
    showDialog(
        context: this.context,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text("Please choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    getfromcamera();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt,),
                      Text(" Camera",style: TextStyle(fontSize: 18),) ],
                  ),),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    getfromgallery();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text(" Gallery",style: TextStyle(fontSize: 18),) ],
                  ),),],),);});}

  void updateimageinfirestore()async{
    String filename=DateTime.now().microsecondsSinceEpoch.toString();
    fstorage.Reference reference = fstorage.FirebaseStorage.instance.ref()
        .child("Patients/Patient Profile").child(filename);

    fstorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
    fstorage.TaskSnapshot taskSnapshot =await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url)async{
      imageurl =url;
    });

    await FirebaseFirestore.instance.collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"image":imageurl});
    // image url will contain the downloaded pic
  }
  @override
  Widget build(BuildContext context) {
    var screenSize= MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: (Colors.white),
          elevation: 0,
          leading: GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=> home()));},

            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
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
                    padding: const EdgeInsets.only(left: 13.0,right: 8),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(60)

                        ),
                        width: 80,
                        height: 80,
                        child:
                        GestureDetector(
                          onTap:showimage ,
                          child: CircleAvatar(
                              backgroundColor:  Colors.white.withOpacity(0.9),
                              minRadius: 90,
                              backgroundImage: imageXFile == null
                                  ? NetworkImage(image!) //already used image
                                  : Image.file(imageXFile!).image //updated one,


                          ),
                        )
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "" + username!,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  IconButton(
                      onPressed: () {
                        _displayTextInputDialog(context);
                      },
                      icon: Icon(Icons.edit)),
                  SizedBox(
                    width: 20,
                  ),

                  //to show qrcode in profile page
                  // QRCode().capture_widget(),


                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      // borderRadius: BorderRadius.circular(60)
                    ),

                    width: 80,
                    height: 80,

                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => QRCode()));
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black.withOpacity(0.8),
                        size: 80,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, left: 55, right: 55),
                child: Container(
                    child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text("Email Address",
                            style:
                            TextStyle(color: Color(0xFF22C698D)),
                          ),
                          SizedBox(
                            height: 10,
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
                            height: 15,
                          ),
                          Container(
                              child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone number",
                                      style: TextStyle(color: Color(0xFF22C698D)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        setState(() {
                                          newnumber = value;
                                        });
                                      },
                                      controller: phonecontroller,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF22C698D),
                                              )),
                                          hintText: ("" + phonenumber!),

                                          suffixIcon: GestureDetector(
                                            onTap: () {

                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            ),
                                          ),
                                          prefixIcon: Icon(Icons.phone,
                                              color: Color(0xFF22C698D)),
                                          border: OutlineInputBorder()),
                                    ),
                                    SizedBox(height: 15),

                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Age",
                                            style: TextStyle(
                                                color: Color(
                                                    0xFF22C698D)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            controller: agecontroller,
                                            keyboardType: TextInputType
                                                .number,
                                            onChanged: (value) {
                                              setState(() {
                                                newage = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(
                                                      color: Color(
                                                          0xFF22C698D),
                                                    )),

                                                hintText: ("enter your age"),

                                                border: OutlineInputBorder()),
                                          ),
                                          SizedBox(height: 15,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "confirm password",
                                                  style: TextStyle(
                                                      color: Color(
                                                          0xFF22C698D)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  onChanged: (value) {

                                                  },
                                                  decoration:
                                                  InputDecoration(
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                          BorderSide(
                                                            color: Color(
                                                                0xFF22C698D),
                                                          )),

                                                      hintText:
                                                      ("*********"),

                                                      border:
                                                      OutlineInputBorder()),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]))
                        ]))),

            // image: new AssetImage("assets/prescreption.png"),
            SizedBox(height: 10,),
            Container(
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((
                          states) =>
                          Color(
                              0xFF22C698D))
                  ),
                  onPressed: () {
                    setState(() {
                      _updatephone();
                      _updateage();
                    });
                  },
                  child: Text("SAVE")
              ),
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
                  child: Image.asset(
                      "assets/images/signout.png"
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 340.0, bottom: 5),
              child: Text('sign out', textAlign: TextAlign.right,),
            ),

          ]),
        ));
  }}