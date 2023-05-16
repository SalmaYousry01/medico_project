// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'Patient_Database.dart';
//
//
//  CollectionReference<Yourpatient> getthepatientCollection() {
//     return DatabaseUtilspatient.getUsersCollection()
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection(Yourpatient.YOUR_PATIENT)
//         .withConverter<Yourpatient>(
//         fromFirestore: (snapshot, s) => Yourpatient.fromJson(snapshot.data()!),
//         toFirestore: (yourpatient, sp) => yourpatient.tojson()
//     );
//   }
//
//
//
//   Future<void> AddpatientdoctorToFirestore(Yourpatient yourpatient) {
//   var collection = getthepatientCollection();
//   var docRef = collection.doc();
//  yourpatient.id = docRef.id;
//   return docRef.set(yourpatient);
// }
//
// static Future<List<DoctorDataBase>> readDoctorFromFirestore() async {
// var snapshot = await getUsersCollection().get();
// return snapshot.docs.map((e) => e.data()).toList();
// }
