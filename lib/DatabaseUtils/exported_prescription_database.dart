import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import 'package:grad_project/models/my_patient.dart';
import '../models/my_prescription__exported_pdf.dart';

class DatabaseUtilsMyprescpdf {
  static CollectionReference<Myprescpdf> getPrescCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyPatient.COLLECTION_NAME)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Myprescpdf.PRESC_PDF)
        .withConverter<Myprescpdf>(
            fromFirestore: (snapshot, options) =>
                Myprescpdf.fromjson(snapshot.data()!),
            toFirestore: (Myprescpdf, options) => Myprescpdf.tojson());
  }

  // static CollectionReference<Myprescpdf> getPrescCollectionToPatient() {
  //   return DatabaseUtilspatient.getPatientsCollection()
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection(Myprescpdf.PRESC_PDF)
  //       .withConverter<Myprescpdf>(
  //       fromFirestore: (snapshot, options) =>
  //           Myprescpdf.fromjson(snapshot.data()!),
  //       toFirestore: (Myprescpdf, options) => Myprescpdf.tojson());
  // }

  static Future<void> AddPrescrToFirestore(Myprescpdf prescpdf) {
    final collection = getPrescCollection();
    final docId = collection.doc().id;
    prescpdf.id = docId;
    return getPrescCollection().doc(docId).set(prescpdf);
  }

  static Stream<QuerySnapshot<Myprescpdf>> getPrecscAsStream() {
    return DatabaseUtilsMyprescpdf.getPrescCollection().snapshots();
  }

  static Future<void> UpdatePrescToFirestore(Myprescpdf prescpdf) {
    log("updating.... id :${prescpdf.id}");
    return getPrescCollection().doc(prescpdf.id).update(prescpdf.tojson());
  }

  static Future<Myprescpdf?> readUserFromFiresore(String id) async {
    DocumentSnapshot<Myprescpdf> user =
        await getPrescCollection().doc(id).get();
    var PrescDataBase = user.data();
    return PrescDataBase;
  }
}
