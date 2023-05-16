import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:grad_project/models/my_doctor.dart';
import 'Patient_Database.dart';
class DatabaseUtilsDoctorPatient{

  static CollectionReference<DoctorDataBase> getthedoctorCollection() {
    return DatabaseUtilspatient.getUsersCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(DoctorDataBase.COLLECTION_NAME)
        .withConverter<DoctorDataBase>(
        fromFirestore: (snapshot, s) =>
            DoctorDataBase.fromJson(snapshot.data()!),
        toFirestore: (yourdoctor, sp) => yourdoctor.tojson());
  }

  static Future<QuerySnapshot<DoctorDataBase>> getdoctortofirestore() {
    return getthedoctorCollection().get();
  }

  static Future<void> AddpatientdoctorToFirestore(DoctorDataBase yourdoctor) {
    Get.snackbar("Doctor Added",
        "you have added doctor ${yourdoctor.fullName} to your doctors",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    var collection = getthedoctorCollection();
    var docRef = collection.doc();
    yourdoctor.id = docRef.id;
    return docRef.set(yourdoctor);
  }

  static Future<void> deletedoctorfirestore(DoctorDataBase yourdoctor) {
    Get.snackbar("Doctor Removed",
        "you have Removed doctor ${yourdoctor.fullName} from your doctors",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    return getthedoctorCollection().doc(yourdoctor.id).delete();
  }

}







