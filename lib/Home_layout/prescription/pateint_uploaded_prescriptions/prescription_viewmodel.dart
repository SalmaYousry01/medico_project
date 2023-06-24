import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grad_project/DatabaseUtils/prescription_database.dart';
import 'package:grad_project/models/my_prescription.dart';
import 'package:grad_project/Home_layout/prescription/pateint_uploaded_prescriptions/prescription_navigator.dart';
import '../../../basenavigator.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

class PrescriptionViewModel extends BaseViewModel<PrescriptionNavigator> {
  // var auth = FirebaseAuth.instance;
  late Myprescription myprescription;
  String url = "";
  int? number;

  Future<void> uploadpdfToFirebase() async {
    //generate random number
    number = Random().nextInt(10);

    //pick pdf file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    //uploading file to firebase
    var pdfFile = fstorage.FirebaseStorage.instance
        .ref()
        .child("patient pdf")
        .child(name);
    fstorage.UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    //upload url to cloud firebase
    final prescription =
        Myprescription(fileUrl: url, num: "Prescription $number");
    DatabaseUtilsMyPrescription.AddPrescriptionToFirestore(prescription);
  }

  void UpdatePrescriptionToDB(String image, String fileUrl, String num) {
    Myprescription prescription = Myprescription(
      fileUrl: fileUrl,
      num: num,
    );

    DatabaseUtilsMyPrescription.AddPrescriptionToFirestore(prescription)
        .then((value) {
      print("Prescription updated");
    }).catchError((error) {});
  }
}
