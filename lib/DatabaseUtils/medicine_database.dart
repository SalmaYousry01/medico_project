import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/models/my_medicine.dart';

import 'Patient_Database.dart';

class DatabaseUtilsmedicine {
  //CollectionReference<Mymedicine> getNotesCollection() {
  //return FirebaseFirestore.instance
  //  .collection(Mymedicine.COLLECTION_NAME)
  //.withConverter<Mymedicine>(
  //fromFirestore: (snapshot, options) =>
  //  Mymedicine.fromjson(snapshot.data()!),
  //toFirestore: (value, options) => value.tojson(),
  //);
  //}

  //Future<void> AddNotesToFirestore(Mymedicine medicine) {
  //return getNotesCollection().doc(note.id).set(note);
  //}
  static CollectionReference<Mymedicine> getUsersCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Mymedicine.COLLECTION_NAME)
        .withConverter<Mymedicine>(
            fromFirestore: (snapshot, s) =>
                Mymedicine.fromjson(snapshot.data()!),
            toFirestore: (medicine, sp) => medicine.tojson());
  }

  static CollectionReference<Mymedicine> getmedicineCollection() {
    return getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Mymedicine.COLLECTION_NAME)
        .withConverter<Mymedicine>(
            fromFirestore: (snapshot, s) =>
                Mymedicine.fromjson(snapshot.data()!),
            toFirestore: (medicine, sp) => medicine.tojson());
  }

//Future<void>addnotetofirestore(Mymedicine note){
  //   return  getNotesCollection().doc(note.id).set(note);

//}
  static Future<void> AddmedicineToFirestore(Mymedicine medicine) {
    // var collection=getClinicsCollection();
    // var docRef=collection.doc();
    // clinic.catId=docRef.id;
    // return docRef.set(clinic);
    return getmedicineCollection().doc(medicine.id).set(medicine);
  }

  static Future<void> Updateemedicinetofirestore(Mymedicine R) {
    return getmedicineCollection().doc(R.id).update(R.tojson());
  }

  static Future<void> UpdatemedicineToFirestore(Mymedicine medicine) {
    log("updating.... id :${medicine.id}");
    return getmedicineCollection().doc(medicine.id).update(medicine.tojson());
  }

  static Future<Mymedicine?> readMedicineFromFiresore(String id) async {
    DocumentSnapshot<Mymedicine> user =
        await getmedicineCollection().doc(id).get();
    var medicineDataBase = user.data();
    return medicineDataBase;
  }

  static Future<Mymedicine?> getMedicineCollectionFromId(String id) async {
    QuerySnapshot<Mymedicine> medicineCollction =
        await DatabaseUtilspatient.getPatientsCollection()
            .doc(id)
            .collection(Mymedicine.COLLECTION_NAME)
            .withConverter<Mymedicine>(
              fromFirestore: (snapshot, options) =>
                  Mymedicine.fromjson(snapshot.data()!),
              toFirestore: (Mymedicine, options) => Mymedicine.tojson(),
            )
            .get();

    var medicineDataBase = medicineCollction.docs.first.data();
    return medicineDataBase;
  }
}

CollectionReference<Mymedicine> getmedicineCollection() {
  return DatabaseUtilspatient.getPatientsCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Mymedicine.COLLECTION_NAME)
      .withConverter<Mymedicine>(
          fromFirestore: (snapshot, s) => Mymedicine.fromjson(snapshot.data()!),
          toFirestore: (medicine, sp) => medicine.tojson());
}

Future<QuerySnapshot<Mymedicine>> getmedicinetofirestore() {
  return getmedicineCollection().get();
}

Future<void> AddmedicineToFirestore(Mymedicine medicine) {
  var collection = getmedicineCollection();
  var docRef = collection.doc();
  medicine.id = docRef.id;
  return docRef.set(medicine);
}

Future<void> deletemedicinetofirestore(Mymedicine medicine) {
  return getmedicineCollection().doc(medicine.id).delete();
}
