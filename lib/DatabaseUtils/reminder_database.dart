import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/models/my_reminder.dart';

import 'Patient_Database.dart';

class DatabaseUtilsReminder {
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
  static CollectionReference<MyReminder> getUsersCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyReminder.COLLECTION_NAME)
        .withConverter<MyReminder>(
        fromFirestore: (snapshot, s) => MyReminder.fromjson(snapshot.data()!),
        toFirestore: (reminder1, sp) => reminder1.tojson()
    );
  }
  static CollectionReference<MyReminder> getReminderCollection() {
    return getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyReminder.COLLECTION_NAME)
        .withConverter<MyReminder>(
        fromFirestore: (snapshot, s) => MyReminder.fromjson(snapshot.data()!),
        toFirestore: (reminder1, sp) => reminder1.tojson());
  }

//Future<void>addnotetofirestore(Mymedicine note){
  //   return  getNotesCollection().doc(note.id).set(note);

//}
  static Future<void> AddReminderToFirestore(MyReminder reminder) {
    // var collection=getClinicsCollection();
    // var docRef=collection.doc();
    // clinic.catId=docRef.id;
    // return docRef.set(clinic);
    return getReminderCollection().doc(reminder.id).set(reminder);
  }

  static Future<void> UpdateeRemindertofirestore(MyReminder R) {
    return getReminderCollection().doc(R.id).update(R.tojson());
  }

  static Future<void> UpdateReminderToFirestore(MyReminder reminder) {
    log("updating.... id :${reminder.id}");
    return getReminderCollection().doc(reminder.id).update(reminder.tojson());
  }

  static Future<MyReminder?> readUserFromFiresore(String id) async {
    DocumentSnapshot<MyReminder> user = await getReminderCollection().doc(id).get();
    var medicineDataBase = user.data();
    return medicineDataBase;
  }
}

CollectionReference<MyReminder> getReminderCollection() {
  return DatabaseUtilspatient.getPatientsCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(MyReminder.COLLECTION_NAME)
      .withConverter<MyReminder>(
      fromFirestore: (snapshot, s) => MyReminder.fromjson(snapshot.data()!),
      toFirestore: (reminder1, sp) => reminder1.tojson());
}

Future<QuerySnapshot<MyReminder>> getRemindertofirestore() {
  return getReminderCollection().get();
}

Future<void> AddReminderToFirestore(MyReminder reminder) {
  var collection = getReminderCollection();
  var docRef = collection.doc();
  reminder.id = docRef.id;
  return docRef.set(reminder);
}

Future<void> deleteRemindertofirestore(MyReminder reminder) {
  return getReminderCollection().doc(reminder.id).delete();

}
