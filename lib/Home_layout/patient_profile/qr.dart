import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:grad_project/Home_layout/patient_profile/profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

class QRCode extends StatefulWidget {
  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  final _screenshotController = ScreenshotController();
  String qrcode = "";
  String? qrcodeurl;
  File? qrXFile;

  void updateqrinfirestore() async {
    // Capture the screenshot of the QR code
    Uint8List? pngBytes = await _screenshotController.capture();

    // Upload the screenshot to Firebase Storage
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Patients/Patient QR")
        .child(filename);

    UploadTask uploadTask = reference.putData(pngBytes!);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    await taskSnapshot.ref.getDownloadURL().then((url) async {
      qrcodeurl = url;
    });

    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"qrcode": qrcodeurl});
    // image url will contain the downloaded pic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.white),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ProfileTab()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text('QR Generation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: _screenshotController,
              child: QrImage(
                data: qrcode,
                version: QrVersions.auto,
                gapless: false,
                errorCorrectionLevel: QrErrorCorrectLevel.L,
                size: 200.0,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 300.0,
              child: TextField(
                //we will generate a new qr code when the input value change
                onChanged: (value) {
                  setState(() {
                    qrcode = value;
                  });
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2C698D),
                ),
                decoration: InputDecoration(
                  hintText: "Type the Data",
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              child: ElevatedButton(
                onPressed: () {
                  updateqrinfirestore;
                  Get.snackbar(
                    "Hello",
                    "Your QRCode has been generated",
                    icon: Icon(Icons.qr_code),
                    borderRadius: 20,
                    duration: Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  // Navigator.pushReplacement(
                  //     context, MaterialPageRoute(builder: (_) => ProfileTab()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                  Color(0xFF22C698D),
                )),
                child: Text('Generate QR Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget capture_widget() {
    return QrImage(
      data: qrcode,
      version: QrVersions.auto,
      gapless: false,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
      size: 200.0,
    );
  }
}
