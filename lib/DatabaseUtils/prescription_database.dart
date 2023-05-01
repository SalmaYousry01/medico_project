import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import '../models/my_prescription.dart';

class DatabaseUtilsMyPrescription {
  static CollectionReference<Myprescription> getPrescriptionCollection() {
    return DatabaseUtilspatient.getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Myprescription.PRESCRIPTION)
        .withConverter<Myprescription>(
            fromFirestore: (snapshot, options) =>
                Myprescription.fromjson(snapshot.data()!),
            toFirestore: (Myprescription, options) => Myprescription.tojson());
  }

  static Future<void> AddPrescriptionToFirestore(Myprescription prescription) {
    final collection = getPrescriptionCollection();
    final docId = collection.doc().id;
    prescription.id = docId;
    return getPrescriptionCollection().doc(docId).set(prescription);
  }

  static Stream<QuerySnapshot<Myprescription>> getPrecscriotionsAsStream() {
    return DatabaseUtilsMyPrescription.getPrescriptionCollection().snapshots();
  }

  static Future<void> UpdatePrescriptionToFirestore(
      Myprescription prescription) {
    log("updating.... id :${prescription.id}");
    return getPrescriptionCollection()
        .doc(prescription.id)
        .update(prescription.tojson());
  }

  static Future<Myprescription?> readUserFromFiresore(String id) async {
    DocumentSnapshot<Myprescription> user =
        await getPrescriptionCollection().doc(id).get();
    var PrescriptionDataBase = user.data();
    return PrescriptionDataBase;
  }
}
