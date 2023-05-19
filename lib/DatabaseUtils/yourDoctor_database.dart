import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:grad_project/DatabaseUtils/doctor_database.dart';
import 'package:grad_project/models/my_doctor.dart';
import '../models/my_patient.dart';
import 'Patient_Database.dart';

class DatabaseUtilsDoctorPatient {

  static CollectionReference<DoctorDataBase> getTheDoctorCollection() {
    return DatabaseUtilspatient.getPatientsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(DoctorDataBase.COLLECTION_NAME)
        .withConverter<DoctorDataBase>(
        fromFirestore: (snapshot, s) =>
            DoctorDataBase.fromJson(snapshot.data()!),
        toFirestore: (yourdoctor, sp) => yourdoctor.tojson());
  }


  static Future<QuerySnapshot<DoctorDataBase>> getDoctorToFirestore() {
    return getTheDoctorCollection().get();
  }

  static Future<void> addPatientDoctorToFirestore(DoctorDataBase yourDoctor) {
    Get.snackbar("Doctor Added",
        "you have added doctor ${yourDoctor.fullName} to your doctors",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    var collection = getTheDoctorCollection();
    // var docRef = collection.doc();
    // yourDoctor.id = docRef.id;
    return collection.doc(yourDoctor.id).set(yourDoctor);
  }

  static Future<void> deleteDoctorFirestore(DoctorDataBase yourDoctor) {
    Get.snackbar("Doctor Removed",
        "you have Removed doctor ${yourDoctor.fullName} from your doctors",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 1));
    return getTheDoctorCollection().doc(yourDoctor.id).delete();
  }

  static Future<void> addPetientToDoctorFirestore(
      DoctorDataBase yourDoctor, MyPatient patient) async {
    final doctorDoc = await DatabaseUtilsdoctor.readUserDocumentFromFiresore(
        yourDoctor.id);
    doctorDoc.reference.collection(doctorPatientsCollection).add(patient.tojson());
  }


  static const String doctorPatientsCollection = "Patients";

}







