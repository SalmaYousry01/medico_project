import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import '../models/my_allergies.dart';

class DatabaseUtilsAllergy {
  static CollectionReference<MyAllergy> getUsersCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyAllergy.COLLECTION_NAME)
        .withConverter<MyAllergy>(
            fromFirestore: (snapshot, s) =>
                MyAllergy.fromjson(snapshot.data()!),
            toFirestore: (allergy, sp) => allergy.tojson());
  }

  static CollectionReference<MyAllergy> getAllergyCollection() {
    return getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyAllergy.COLLECTION_NAME)
        .withConverter<MyAllergy>(
            fromFirestore: (snapshot, s) =>
                MyAllergy.fromjson(snapshot.data()!),
            toFirestore: (allergy, sp) => allergy.tojson());
  }

  static Future<void> AddAllergyToFirestore(MyAllergy allergy) {
    return getAllergyCollection().doc(allergy.id).set(allergy);
  }

  static Future<void> UpdateeAllergytofirestore(MyAllergy A) {
    return getAllergyCollection().doc(A.id).update(A.tojson());
  }

  static Future<void> UpdateAllergyToFirestore(MyAllergy allergy) {
    log("updating.... id :${allergy.id}");
    return getAllergyCollection().doc(allergy.id).update(allergy.tojson());
  }

  static Future<MyAllergy?> readUserFromFiresore(String id) async {
    DocumentSnapshot<MyAllergy> user =
        await getAllergyCollection().doc(id).get();
    var AllergyDataBase = user.data();
    return AllergyDataBase;
  }
}

CollectionReference<MyAllergy> getAllergyCollection() {
  return DatabaseUtilspatient.getPatientsCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(MyAllergy.COLLECTION_NAME)
      .withConverter<MyAllergy>(
          fromFirestore: (snapshot, s) => MyAllergy.fromjson(snapshot.data()!),
          toFirestore: (allergy, sp) => allergy.tojson());
}

Future<QuerySnapshot<MyAllergy>> getAllergytofirestore() {
  return getAllergyCollection().get();
}

Future<void> AddAllergyToFirestore(MyAllergy allergy) {
  var collection = getAllergyCollection();
  var docRef = collection.doc();
  allergy.id = docRef.id;
  return docRef.set(allergy);
}

Future<void> deleteallergytofirestore(MyAllergy allergy) {
  return getAllergyCollection().doc(allergy.id).delete();
}
