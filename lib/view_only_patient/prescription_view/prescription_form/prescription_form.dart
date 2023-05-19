import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/Home_layout/home.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:pdf/widgets.dart' as pw;
import '../../../DatabaseUtils/exported_prescription_database.dart';
import '../../../Home_layout/prescription/prescription_exported_pdfs/doctor_uploaded_prescription.dart';
import '../../../models/my_clinic.dart';
import '../../../models/my_prescription__exported_pdf.dart';
import '../../../models/my_prescription_form.dart';


class DoctorPrescription extends StatefulWidget {
  @override
  DoctorPrescriptionState createState() => DoctorPrescriptionState();
}

class DoctorPrescriptionState extends State<DoctorPrescription> {
  final parentDocRef = FirebaseFirestore.instance
      .collection('Patients')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final subcollectionRef = FirebaseFirestore.instance
      .collection('Patients')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Myprescriptionform.PRESCRIPTION_FORM);

  TextEditingController _medicineEditingController = TextEditingController();
  TextEditingController _testEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();
  TextEditingController signatureEditingController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _showList = false;

  List<String> medicine_list = [];
  String? medicine;
  String? tests;
  List<String> tests_list = [];
  List<String> date_list = [];
  List<String> signature_list = [];
  final List<String> dosage_list = ["0.25", "0.5", "1", "1.5", "2", "2.5", "3"];
  List<String> empty_dosage_list = [];
  String? dosage;
  final List<String> time_list = [
    "Every 4 hours",
    "Every 6 hours",
    "Every 8 hours",
    "Every 12 hours"
  ];

  List<String> empty_time_list = [];
  String? time;
  String? phoneNumber = "";
  String? date;
  String? signature;

  final ScreenshotController _controller = ScreenshotController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String url = "";
  int? number;

  Future<void> uploadpdfToFirebase() async {
    //generate random number
    number = Random().nextInt(10);
    String name = DateTime.now().millisecondsSinceEpoch.toString();
    final imageBytes = await _controller.capture();
    final pdfBytes = await _createPdf(imageBytes!);
    var pdfFile = fstorage.FirebaseStorage.instance
        .ref()
        .child("Patients/pdf")
        .child(name);
    fstorage.UploadTask task = pdfFile.putData(pdfBytes);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    //upload url to cloud firebase
    final prescpdf = Myprescpdf(fileUrl: url, num: "Prescription $number");
    DatabaseUtilsMyprescpdf.AddPrescrToFirestore(prescpdf);
  }

  Future<Uint8List> _createPdf(Uint8List imageBytes) async {
    final document = pw.Document();
    document.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(pw.MemoryImage(imageBytes)),
        );
      },
    ));
    return document.save();
  }

  Future<void> _showPrescriptionList(BuildContext context) async {
    await uploadpdfToFirebase();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PrescListPage(myPrescriptionStream: myPrescriptionStream)));
  }

  Stream<QuerySnapshot<Myprescpdf>>? myPrescriptionStream;

  void _addData() {
    subcollectionRef.add({
      'medicine': _medicineEditingController.text,
      'test': _testEditingController.text,
      'dosage': dosage,
      'time': time,
      "prescription": prescription,
      "date": dateEditingController.text,
      "signature": signatureEditingController.text
    });
  }

  medicine_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add medicine",
        text: "error");
  }

  dosage_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add dosage",
        text: "error");
  }

  time_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add dosage",
        text: "error");
  }

  test_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add required tests",
        text: "error");
  }

  date_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add required tests",
        text: "error");
  }

  signature_alert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "please add required tests",
        text: "error");
  }

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection(MyClinic.CLINIC_PROFILE)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      //means if data exists
      if (snapshot.exists) {
        setState(() {
          phoneNumber = snapshot.data()!["phoneNumber"];
        });
      }
    });
  }

  void initState() {
    super.initState();
    _getDataFromDatabase();
    myPrescriptionStream =
        DatabaseUtilsMyprescpdf.getPrescCollection().snapshots();
  }

  String prescription = "";
  String? prescriptionurl;
  File? prescriptionXFile;

  void updateprescinfirestore() async {
    // Capture the screenshot of the QR code
    Uint8List? pngBytes = await _controller.capture();

    // Upload the screenshot to Firebase Storage
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Patients/Doctor uploaded prescription")
        .child(filename);

    UploadTask uploadTask = reference.putData(pngBytes!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    await taskSnapshot.ref.getDownloadURL().then((url) async {
      prescriptionurl = url;
    });

    await FirebaseFirestore.instance
        .collection(Myprescriptionform.PRESCRIPTION_FORM)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"prescription": prescriptionurl});
    // image url will contain the downloaded pic
  }

  @override
  void dispose() {
    _medicineEditingController.dispose();
    _testEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: (Colors.white),
          elevation: 0,
          actions: [
            GestureDetector(
                onTap: () => _showPrescriptionList(context),
                child: Visibility(
                    visible: _showList,
                    child: Icon(
                      Icons.picture_as_pdf,
                      color: Color(0xFF22C698D),
                      size: 35,
                    ))),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/prescription.png"),
                  fit: BoxFit.fill)),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0),
                    borderRadius: BorderRadius.circular(10),
                    //  border: Border.all(color: Color(0xFF22C698D) )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          heightFactor: 0,
                          child: Text(
                            'Prescription Form',
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 8.0, bottom: 3),
                        child: Row(
                          children: [
                            Icon(Icons.badge_rounded),
                            Text(" Clinic Name"),
                            SizedBox(
                              width: 130,
                            ),
                            Text("Doctor Name")
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 3, left: 6.0, bottom: 3),
                        child: Row(
                          children: [
                            Icon(Icons.phone),
                            Text("Phone Number" + phoneNumber!),
                            SizedBox(
                              width: 120,
                            ),
                            Text("Doctor Major")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          "Medicine Name",
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 5,
                          bottom: 5,
                        ),
                        child: TextFormField(
                          controller: _medicineEditingController,
                          decoration: InputDecoration(
                              hintText: 'Enter a value',
                              labelText: 'Medicine name',
                              border: OutlineInputBorder()),
                          validator: ((val) {
                            if (val!.length >= 15) {
                              return null;
                            } else {
                              return "Enter medicine name";
                            }
                          }),
                          // onFieldSubmitted: (String value) {
                          //   print(value);
                          // },
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            Text(
                              'Dosage  ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              height: 30,
                              width: 58,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2))),
                              child: DropdownButton<String>(
                                value: dosage,
                                onChanged: (value) {
                                  setState(() {
                                    dosage = value;
                                  });
                                },
                                items: dosage_list
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Time   ",
                              style: TextStyle(fontSize: 18),
                            ),
                            Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2))),
                              child: DropdownButton<String>(
                                value: time,
                                onChanged: (value) {
                                  setState(() {
                                    time = value;
                                  });
                                },
                                items: time_list
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 3,
                          bottom: 3,
                        ),
                        child: Text(
                          "Required Tests",
                          style: TextStyle(fontSize: 17.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 3,
                          bottom: 3,
                        ),
                        child: TextFormField(
                          controller: _testEditingController,
                          decoration: InputDecoration(
                              hintText: 'Enter a value',
                              labelText: 'Required Tests',
                              border: OutlineInputBorder()),

                          // validator: ((val) {
                          //   if (val!.length >= 15) {
                          //     return null;
                          //   } else {
                          //     return "Enter required test";
                          //   }
                          // })
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 3),
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: dateEditingController,
                                  decoration: InputDecoration(
                                      labelText: 'Date', hintText: "dd-mm-yy"),
                                ),
                              ),
                              SizedBox(width: 16),
                              Flexible(
                                child: TextFormField(
                                  controller: signatureEditingController,
                                  decoration: InputDecoration(
                                    labelText: 'Signature',
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                            Color(0xFF22C698D),
                          )),
                          onPressed: () {
                            setState(() {
                              _addData();
                              if (_medicineEditingController.text.isNotEmpty) {
                                medicine_list
                                    .add(_medicineEditingController.text);
                                _medicineEditingController.clear();
                              } else {
                                return medicine_alert();
                              }
                              if (dosage != null) {
                                empty_dosage_list.add(dosage!);
                              } else {
                                return dosage_alert();
                              }
                              if (time != null) {
                                empty_time_list.add(time!);
                              } else {
                                return time_alert();
                              }
                              if (_testEditingController.text.isNotEmpty) {
                                tests_list.add(_testEditingController.text);
                                _testEditingController.clear();
                              } else {
                                return test_alert();
                              }

                              if (dateEditingController.text.isNotEmpty) {
                                date_list.add(dateEditingController.text);
                                dateEditingController.clear();
                              } else {
                                return date_alert();
                              }

                              if (signatureEditingController.text.isNotEmpty) {
                                signature_list
                                    .add(signatureEditingController.text);
                                signatureEditingController.clear();
                              } else {
                                return signature_alert();
                              }

                              _showList = true;

                              updateprescinfirestore();
                            });
                          },
                          child: Text('Submit Prescription'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //wrap all with column and try screenshot widget
              Screenshot(
                controller: _controller,
                child: Column(
                  children: [
                    Visibility(
                      visible: _showList,
                      child: Container(
                        width: 500,
                        height: 500,
                        //margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          //border: Border.all(),
                          color: Colors.white.withOpacity(0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: subcollectionRef.snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              return ListView.builder(
                                itemCount: medicine_list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(medicine_list[index]),
                                        subtitle:
                                            Text(empty_dosage_list[index]),
                                        trailing: Text(empty_time_list[index]),
                                      ),
                                      ListTile(
                                        title: Text("Required tests",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        subtitle: Text(
                                          tests_list[index],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          signature_list[index],
                                        ),
                                        trailing: Text(date_list[index]),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
