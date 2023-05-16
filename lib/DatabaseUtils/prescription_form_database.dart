import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/models/my_prescription_form.dart';

class DatabaseUtilsPrescriptionForm {
  static CollectionReference<Myprescriptionform>
      getPrescriptionFormCollection() {
    return DatabaseUtilspatient.getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Myprescriptionform.PRESCRIPTION_FORM)
        .withConverter<Myprescriptionform>(
            fromFirestore: (snapshot, s) =>
                Myprescriptionform.fromjson(snapshot.data()!),
            toFirestore: (prescription_form, sp) => prescription_form.tojson());
  }

  static Future<void> AddPrescriptionFormToFirestore(
      Myprescriptionform prescription_form) {
    return getPrescriptionFormCollection()
        .doc(prescription_form.id)
        .set(prescription_form);
  }

  static Future<void> Updateeprescriptionformtofirestore(Myprescriptionform p) {
    return getPrescriptionFormCollection().doc(p.id).update(p.tojson());
  }

  static Future<void> UpdatePrescriptionFormToFirestore(
      Myprescriptionform prescription_form) {
    log("updating.... id :${prescription_form.id}");
    return getPrescriptionFormCollection()
        .doc(prescription_form.id)
        .update(prescription_form.tojson());
  }

  static Future<Myprescriptionform?> readUserFromFiresore(String id) async {
    DocumentSnapshot<Myprescriptionform> user =
        await getPrescriptionFormCollection().doc(id).get();
    var PrescriptionFormDataBase = user.data();
    return PrescriptionFormDataBase;
  }
}

CollectionReference<Myprescriptionform> getPrescriptionFormCollection() {
  return DatabaseUtilspatient.getUsersCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Myprescriptionform.PRESCRIPTION_FORM)
      .withConverter<Myprescriptionform>(
          fromFirestore: (snapshot, s) =>
              Myprescriptionform.fromjson(snapshot.data()!),
          toFirestore: (prescription_form, sp) => prescription_form.tojson());
}

Future<QuerySnapshot<Myprescriptionform>> getprescriptionformtofirestore() {
  return getPrescriptionFormCollection().get();
}

Future<void> AddPrescriptionFormToFirestore(
    Myprescriptionform prescription_form) {
  var collection = getPrescriptionFormCollection();
  var docRef = collection.doc();
  prescription_form.id = docRef.id;
  return docRef.set(prescription_form);
}

Future<void> deleteprescriptionformtofirestore(
    Myprescriptionform prescription_form) {
  return getPrescriptionFormCollection().doc(prescription_form.id).delete();
}
