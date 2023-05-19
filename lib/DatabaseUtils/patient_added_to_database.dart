import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project/models/my_patient.dart';

class DatabaseUtilsPateintAddedToDatabase {
  static CollectionReference<MyPatient> getPatientsCollection() {
    return FirebaseFirestore.instance
        .collection(MyPatient.COLLECTION_NAME)
        .withConverter<MyPatient>(
          fromFirestore: (snapshot, options) =>
              MyPatient.fromjson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }

  static Future<void> AddAddedPatientToFirestore(MyPatient myPatient) {
    return getPatientsCollection().doc(myPatient.id).set(myPatient);
  }
}
