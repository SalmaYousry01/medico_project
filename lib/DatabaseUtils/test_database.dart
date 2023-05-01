import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/my_test.dart';
import 'Patient_Database.dart';

class DatabaseUtilsTest {
  static CollectionReference<MyTest> getTestCollection() {
    return DatabaseUtilspatient.getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(MyTest.TEST)
        .withConverter<MyTest>(
            fromFirestore: (snapshot, options) =>
                MyTest.fromjson(snapshot.data()!),
            toFirestore: (MyTest, options) => MyTest.tojson());
  }

  static Future<void> AddTestToFirestore(MyTest test) {
    final collection = getTestCollection();
    final docId = collection.doc().id;
    test.id = docId;
    return getTestCollection().doc(docId).set(test);
  }

  static Stream<QuerySnapshot<MyTest>> getTestAsStream() {
    return DatabaseUtilsTest.getTestCollection().snapshots();
  }

  static Future<void> UpdateTestToFirestore(MyTest test) {
    log("updating.... id :${test.id}");
    return getTestCollection().doc(test.id).update(test.tojson());
  }

  static Future<MyTest?> readUserFromFiresore(String id) async {
    DocumentSnapshot<MyTest> user = await getTestCollection().doc(id).get();
    var TestDataBase = user.data();
    return TestDataBase;
  }
}
