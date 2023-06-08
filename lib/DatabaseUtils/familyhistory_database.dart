import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/my_family.dart';
import 'Patient_Database.dart';

class DatabaseUtilsFamilyhistory {
  //CollectionReference<MyReminder> getNotesCollection() {
  //return FirebaseFirestore.instance
  //  .collection(MyReminder.COLLECTION_NAME)
  //.withConverter<MyReminder>(
  //fromFirestore: (snapshot, options) =>
  //  MyReminder.fromjson(snapshot.data()!),
  //toFirestore: (value, options) => value.tojson(),
  //);
  //}

  //Future<void> AddNotesToFirestore(MyReminder note) {
  //return getNotesCollection().doc(note.id).set(note);
  //}
  static CollectionReference<MyFamilyhistory> getUsersCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyFamilyhistory.COLLECTION_NAME)
        .withConverter<MyFamilyhistory>(
        fromFirestore: (snapshot, s) =>
            MyFamilyhistory.fromjson(snapshot.data()!),
        toFirestore: (familyhistory, sp) => familyhistory.tojson());
  }

  static CollectionReference<MyFamilyhistory> getFamilyhistoryCollection() {
    return getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyFamilyhistory.COLLECTION_NAME)
        .withConverter<MyFamilyhistory>(
        fromFirestore: (snapshot, s) =>
            MyFamilyhistory.fromjson(snapshot.data()!),
        toFirestore: (Familyhistory, sp) => Familyhistory.tojson());
  }

//Future<void>addnotetofirestore(MyReminder note){
  //   return  getNotesCollection().doc(note.id).set(note);

//}
  static Future<void> AddFamilyhistoryToFirestore(
      MyFamilyhistory familyhistory) {
    // var collection=getClinicsCollection();
    // var docRef=collection.doc();
    // clinic.catId=docRef.id;
    // return docRef.set(clinic);
    return getFamilyhistoryCollection()
        .doc(familyhistory.id)
        .set(familyhistory);
  }

  static Future<void> UpdateeFamilyhistorytofirestore(MyFamilyhistory A) {
    return getFamilyhistoryCollection().doc(A.id).update(A.tojson());
  }

  static Future<void> UpdateFamilyhistoryToFirestore(
      MyFamilyhistory familyhistory) {
    log("updating.... id :${familyhistory.id}");
    return getFamilyhistoryCollection()
        .doc(familyhistory.id)
        .update(familyhistory.tojson());
  }

  static Future<MyFamilyhistory?> readUserFromFiresore(String id) async {
    DocumentSnapshot<MyFamilyhistory> user =
    await getFamilyhistoryCollection().doc(id).get();
    var FamilyhistoryDataBase = user.data();
    return FamilyhistoryDataBase;
  }
}

CollectionReference<MyFamilyhistory> getFamilyhistoryCollection() {
  return DatabaseUtilspatient.getPatientsCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(MyFamilyhistory.COLLECTION_NAME)
      .withConverter<MyFamilyhistory>(
      fromFirestore: (snapshot, s) =>
          MyFamilyhistory.fromjson(snapshot.data()!),
      toFirestore: (familyhistory, sp) => familyhistory.tojson());
}

Future<QuerySnapshot<MyFamilyhistory>> getFamilyhistorytofirestore() {
  return getFamilyhistoryCollection().get();
}

Future<void> AddFamilyhistoryToFirestore(MyFamilyhistory familyhistory) {
  var collection = getFamilyhistoryCollection();
  var docRef = collection.doc();
  familyhistory.id = docRef.id;
  return docRef.set(familyhistory);
}

Future<void> deleteFamilyhistorytofirestore(MyFamilyhistory familyhistory) {
  return getFamilyhistoryCollection().doc(familyhistory.id).delete();
}
