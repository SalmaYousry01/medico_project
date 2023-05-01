import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/my_doctor.dart';

class DatabaseUtilsdoctor {
  static CollectionReference<DoctorDataBase> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(DoctorDataBase.COLLECTION_NAME)
        .withConverter<DoctorDataBase>(
          fromFirestore: (snapshot, options) =>
              DoctorDataBase.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }

  static Future<void> AddUserToFirestore(DoctorDataBase doctorDataBase) {
    return getUsersCollection().doc(doctorDataBase.id).set(doctorDataBase);
  }

  static Future<DoctorDataBase?> readUserFromFiresore(String id) async {
    DocumentSnapshot<DoctorDataBase> user =
        await getUsersCollection().doc(id).get();
    var doctorDataBase = user.data();
    return doctorDataBase;
  }
}
