import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grad_project/DatabaseUtils/test_database.dart';
import 'package:grad_project/Home_layout/test/test_navigator.dart';
import 'package:grad_project/models/my_test.dart';
import '../../basenavigator.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

class TestViewModel extends BaseViewModel<TestNavigator> {
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
        .child("Patients/Patient Tests")
        .child(name);
    fstorage.UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    //upload url to cloud firebase
    final test = MyTest(fileUrl: url, num: "Test $number");
    DatabaseUtilsTest.AddTestToFirestore(test);
  }

  void UpdateTestToDB(String image, String fileUrl, String num) {
    MyTest test = MyTest(
      fileUrl: fileUrl,
      num: num,
    );

    DatabaseUtilsTest.AddTestToFirestore(test).then((value) {
      print("Test updated");
    }).catchError((error) {});
  }
}
