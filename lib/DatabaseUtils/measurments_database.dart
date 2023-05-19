import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/models/my_measurments.dart';

class DatabaseUtilsMeasurments {
  static CollectionReference<Mymeasurments> getMeasurmentsCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Mymeasurments.MEASURMENTS)
        .withConverter<Mymeasurments>(
            fromFirestore: (snapshot, sp) =>
                Mymeasurments.fromjson(snapshot.data()!),
            toFirestore: (Mymeasurments, sp) => Mymeasurments.tojson());
  }

  static Future<void> AddMeasurmentsToFirestore(Mymeasurments measurments) {
    return getMeasurmentsCollection().doc(measurments.id).set(measurments);
  }

  static Future<void> UpdateMeasurmentsToFirestore(Mymeasurments measurments) {
    log("updating.... id :${measurments.id}");
    return getMeasurmentsCollection()
        .doc(measurments.id)
        .update(measurments.tojson());
  }

  static Future<Mymeasurments?> readMeasurementsFromFiresore(String id) async {
    QuerySnapshot<Mymeasurments> measurementCollection =
        await getMeasurmentsCollection().get();
    var MeasurmentsDataBase = measurementCollection.docs.first.data();
    return MeasurmentsDataBase;
  }
}
