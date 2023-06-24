import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import '../models/my_prescription.dart';

class DatabaseUtilsMyPrescription {
  static CollectionReference<Myprescription> getPrescriptionCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
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

  static Future<Myprescription?> readPrescriptionFromFiresore(String id) async {
    DocumentSnapshot<Myprescription> prescriptionCollection =
        await getPrescriptionCollection().doc(id).get();
    var PrescriptionDataBase = prescriptionCollection.data();
    return PrescriptionDataBase;
  }

  static Future<Myprescription?> readPresFromFiresore() async {
    QuerySnapshot<Myprescription> prescriptionCollection =
        await getPrescriptionCollection().get();

    var prescriptionDataBase = prescriptionCollection.docs.first.data();
    return prescriptionDataBase;
  }
}
