import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/models/my_clinic.dart';
import 'doctor_database.dart';

class DatabaseUtilsClinic {
  static CollectionReference<MyClinic> getClinicsCollection() {
    return DatabaseUtilsdoctor.getDoctorsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyClinic.CLINIC_PROFILE)
        .withConverter<MyClinic>(
          fromFirestore: (snapshot, options) =>
              MyClinic.fromJson(snapshot.data()!),
          toFirestore: (myClinic, options) => myClinic.tojson(),
        );
  }

  static Future<void> AddClinicToFirestore(MyClinic clinic) {
    // var collection=getClinicsCollection();
    // var docRef=collection.doc();
    // clinic.catId=docRef.id;
    // return docRef.set(clinic);
    return getClinicsCollection().doc(clinic.id).set(clinic);
  }

  static Future<void> UpdateClinicToFirestore(MyClinic clinic) {
    log("updating.... id :${clinic.id}");
    return getClinicsCollection().doc(clinic.id).update(clinic.tojson());
  }

  static Future<MyClinic?> readClinicFromFiresore() async {
    QuerySnapshot<MyClinic> clinicCollction =
        await getClinicsCollection().get();

    var clinicDataBase = clinicCollction.docs.first.data();
    return clinicDataBase;
  }

  static Future<MyClinic?> getDoctorClinicsCollectionFromId(String id) async {
    QuerySnapshot<MyClinic> clinicCollction =
        await DatabaseUtilsdoctor.getDoctorsCollection()
            .doc(id)
            .collection(MyClinic.CLINIC_PROFILE)
            .withConverter<MyClinic>(
              fromFirestore: (snapshot, options) =>
                  MyClinic.fromJson(snapshot.data()!),
              toFirestore: (MyClinic, options) => MyClinic.tojson(),
            )
            .get();

    var clinicDataBase = clinicCollction.docs.first.data();
    return clinicDataBase;
  }
}
