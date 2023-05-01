import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import 'package:grad_project/Profile/clinicProfile_navigator.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/Profile/clinic_viewmodel.dart';
import 'package:grad_project/login/doctor_login.dart';
import 'package:grad_project/models/my_clinic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../DatabaseUtils/clinic_database.dart';
import '../models/my_doctor.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

class ClinicProfile extends StatefulWidget {
  static const String routeName = "ClinicProfile";
  bool isDoctor = true;

  ClinicProfile(this.isDoctor);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends BaseView<ClinicProfile, ClinicViewModel>
    with SingleTickerProviderStateMixin
    implements clinicProfileNavigator {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  var feesController = TextEditingController();
  var aboutController = TextEditingController();
  var imagecontroller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    GetDataFromDatabase();
    // _getDataFromDatabase();
    getClinicFromDataase().then((value) {
      addressController.text = value.address;
      phoneController.text = value.phoneNumber;
      startTimeController.text = value.startTime;
      endTimeController.text = value.endTime;
      feesController.text = value.fees;
      aboutController.text = value.about;
      imagecontroller.text = value.image;
    });
  }

  // TimeOfDay startTime = TimeOfDay.now();
  // TimeOfDay endTime = TimeOfDay.now();
  String? name = '';
  String? field = '';
  final imagepicker = ImagePicker();
  String? image = "";
  File? imageXFile;
  String? imageurl;
  var clinicData;

  Future GetDataFromDatabase() async {
    DoctorDataBase? doctor = await DatabaseUtilsdoctor.readUserFromFiresore(
        FirebaseAuth.instance.currentUser!.uid);
    if (doctor != null) {
      setState(() {
        name = doctor.fullName;
        field = doctor.Field;
        image = doctor.image;
      });
    }
  }

  // Future _getDataFromDatabase() async {
  //   await FirebaseFirestore.instance
  //       .collection(MyClinic.CLINIC_PROFILE)
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((snapshot) async {
  //     //means if data exists
  //     if (snapshot.exists) {
  //       setState(() {
  //         image = snapshot.data()!["image"];
  //       });
  //     }
  //   });
  // }

  Future<MyClinic> getClinicFromDataase() async {
    var docs = await DatabaseUtilsClinic.getClinicsCollection().get();
    MyClinic? clinic;
    if (docs.docs.isNotEmpty) {
      clinic = docs.docs[0].data();
    }
    if (clinic != null) {
      setState(() {
        clinicData = clinic;
      });
      return clinic;
    } else {
      return MyClinic.notFound();
    }
  }

  void getfromcamera() async {
    final pickedimage = await imagepicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageXFile = File(pickedimage!.path);
      updateimageinfirestore();
    });

    // XFile?pickedimage =await imagepicker.pickImage(source: ImageSource.camera);
    // imageXFile=File(pickedimage!.path);
    Navigator.pop(this.context);
    // cropimage(pickedimage!.path);
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
    // cropimage(pickedimage!.path);
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
        .child("doctor image")
        .child(filename);

    fstorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
    fstorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) async {
      imageurl = url;
    });

    await FirebaseFirestore.instance
        .collection(MyClinic.CLINIC_PROFILE)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"image": imageurl});
    // image url will contain the downloaded pic
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                  elevation: 0.0,
                  bottomOpacity: 0.0,
                  backgroundColor: Colors.white,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, DoctortLogin.routeName);
                      },
                      icon: const Icon(Icons.arrow_back_outlined),
                      color: Colors.black,
                    ),
                  ))),
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 290.0,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [],
                              )),
                          Stack(fit: StackFit.loose, children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        borderRadius:
                                            BorderRadius.circular(60)),
                                    width: 80,
                                    height: 80,
                                    child: GestureDetector(
                                      onTap: showimage,
                                      child: CircleAvatar(
                                          child: Icon(Icons.camera_alt,
                                              color: Colors.white),
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
                              ],
                            ),

                            // Padding(
                            //     padding: const EdgeInsets.only(
                            //         top: 140.0, right: 100.0),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: const [
                            //         CircleAvatar(
                            //           backgroundColor: Color(0xFF2C698D),
                            //           radius: 25.0,
                            //           child: Icon(Icons.camera_alt,
                            //               color: Colors.white),
                            //         )
                            //       ],
                            //     )),
                          ]),
                          Container(
                            width: 175,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 1, color: const Color(0xFF2C698D)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Dr : " + name!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 0.8,
                                      bottom: 0.8,
                                      top: 0.5),
                                  child: Text(
                                    "Field : " + field!,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xffFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Clinic',
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _status && widget.isDoctor
                                            ? _getEditIcon()
                                            : Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 7),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        controller: addressController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Your Clinic Address',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.69),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C698D))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.69),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C698D))),
                                        ),
                                        enabled: !_status,
                                        autofocus: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Phone',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 7),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Clinic Number',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.69),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C698D))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.69),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C698D))),
                                        ),
                                        enabled: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'Availability',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 7),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: TextFormField(
                                          controller: startTimeController,
                                          decoration: InputDecoration(
                                            hintText: 'Start Time',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.69),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF2C698D))),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.69),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF2C698D))),
                                          ),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: TextFormField(
                                          controller: endTimeController,
                                          decoration: InputDecoration(
                                            hintText: 'End Time',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.69),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF2C698D))),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.69),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF2C698D))),
                                          ),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            // Padding(
                            //   padding: const EdgeInsets.only(top:20,left: 50.0),
                            //   child: ListView(
                            //     shrinkWrap: true,
                            //     children: [
                            //       _buildTimePick("Start", true, startTime, (x) {
                            //         setState(() {
                            //           startTime = x;
                            //           print("The picked time is: $x");
                            //           enabled: !_status;
                            //         });
                            //       }),
                            //       const SizedBox(height: 10),
                            //       _buildTimePick("End", true, endTime, (x) {
                            //         setState(() {
                            //           endTime = x;
                            //           print("The picked time is: $x");
                            //           enabled: !_status;
                            //         });
                            //       }),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: const Text(
                                          'Fees',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(height: 7),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: TextFormField(
                                          controller: feesController,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Your Fees',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.69),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF2C698D))),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7.69),
                                                borderSide: const BorderSide(
                                                    color: Color(0xFF2C698D))),
                                          ),
                                          enabled: !_status,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text(
                                          'About',
                                          style: TextStyle(
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        controller: aboutController,
                                        decoration: InputDecoration(
                                          hintText: 'About Your Clinic',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.69),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C698D))),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.69),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFF2C698D))),
                                        ),
                                        enabled: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            !_status ? _getActionButtons() : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF2C698D),
                    ),
                    child: const Text("Save"),
                    onPressed: () async {
                      await ValidateForm();
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                  )),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF2C698D),
                  ),
                  child: const Text("Cancel"),
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Color(0xFF2C698D),
        radius: 18.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 20.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Future<void> ValidateForm() async {
    if (formKey.currentState!.validate()) {
      await viewModel.AddOrUpdateClinicToDB(
          addressController.text,
          phoneController.text,
          startTimeController.text,
          endTimeController.text,
          feesController.text,
          aboutController.text,
          imagecontroller.text);
    }
  }

  @override
  ClinicViewModel initViewModel() {
    return ClinicViewModel();
  }

// Future selectedTime(BuildContext context, bool ifPickedTime,
//     TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
//   var _pickedTime =
//       await showTimePicker(context: context, initialTime: initialTime);
//   if (_pickedTime != null) {
//     onTimePicked(_pickedTime);
//   }
// }

// Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
//     Function(TimeOfDay) onTimePicked) {
//   return Row(
//     children: [
//       SizedBox(
//         width: 80,
//         child: Text(
//           title,
//         ),
//       ),
//       Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         decoration: BoxDecoration(
//           border: Border.all(),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: GestureDetector(
//           child: Text(
//             currentTime.format(context),
//           ),
//           onTap: () {
//             selectedTime(context, ifPickedTime, currentTime, onTimePicked);
//           },
//         ),
//       ),
//     ],
//   );
// }
}
