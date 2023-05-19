import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grad_project/Home_layout/prescription/prescription_exported_pdfs/prescpdfnavigator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;
import 'package:pdf/widgets.dart' as pw;

import '../../../DatabaseUtils/exported_prescription_database.dart';
import '../../../basenavigator.dart';
import '../../../models/my_prescription__exported_pdf.dart';

class PrescViewModel extends BaseViewModel<PrescNavigator> {
  // var auth = FirebaseAuth.instance;
  String url = "";
  int? number;
  final ScreenshotController _controller = ScreenshotController();

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

  void UpdatePrescToDB(String fileUrl, String num) {
    // final credential = await auth.getRedirectResult();
    Myprescpdf prescpdf = Myprescpdf(
      fileUrl: fileUrl,
      num: num,
    );
    // id: credential.user?.uid ?? ""

    DatabaseUtilsMyprescpdf.AddPrescrToFirestore(prescpdf).then((value) {
      print("Prescription updated");
    }).catchError((error) {});
  }
}
