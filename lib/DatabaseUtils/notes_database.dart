import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import '../models/my_notes.dart';

class DatabaseUtilsNotes {

  static CollectionReference<Mynotes> getNotesCollection() {
    return DatabaseUtilspatient.getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(Mynotes.NOTES)
        .withConverter<Mynotes>(
            fromFirestore: (snapshot, s) => Mynotes.fromjson(snapshot.data()!),
            toFirestore: (note, sp) => note.tojson());
  }


  static Future<void> AddNoteToFirestore(Mynotes note) {
    return getNotesCollection().doc(note.id).set(note);
  }

  static Future<void> Updateenotetofirestore(Mynotes N) {
    return getNotesCollection().doc(N.id).update(N.tojson());
  }

  static Future<void> UpdateNotesToFirestore(Mynotes note) {
    log("updating.... id :${note.id}");
    return getNotesCollection().doc(note.id).update(note.tojson());
  }

  static Future<Mynotes?> readUserFromFiresore(String id) async {
    DocumentSnapshot<Mynotes> user = await getNotesCollection().doc(id).get();
    var NotesDataBase = user.data();
    return NotesDataBase;
  }
}

CollectionReference<Mynotes> getNotesCollection() {
  return DatabaseUtilspatient.getUsersCollection()
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(Mynotes.NOTES)
      .withConverter<Mynotes>(
          fromFirestore: (snapshot, s) => Mynotes.fromjson(snapshot.data()!),
          toFirestore: (note, sp) => note.tojson());
}

Future<QuerySnapshot<Mynotes>> getnotetofirestore() {
  return getNotesCollection().get();
}

Future<void> AddNoteToFirestore(Mynotes note) {
  var collection = getNotesCollection();
  var docRef = collection.doc();
  note.id = docRef.id;
  return docRef.set(note);
}

Future<void> deletenotetofirestore(Mynotes note) {
  return getNotesCollection().doc(note.id).delete();
}
