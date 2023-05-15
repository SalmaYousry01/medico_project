import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/models/my_patient.dart';

class DatabaseUtilspatient {
  static CollectionReference<MyPatient> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyPatient.COLLECTION_NAME)
        .withConverter<MyPatient>(
          fromFirestore: (snapshot, options) =>
              MyPatient.fromjson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }

  static Future<void> AddUserToFirestore(MyPatient patient) {
    return getUsersCollection().doc(patient.id).set(patient);
  }

  static Future<MyPatient?> readPateintFromFiresore(String id) async {
    DocumentSnapshot<MyPatient> user = await getUsersCollection().doc(id).get();
    var patient = user.data();
    return patient;
  }
}
