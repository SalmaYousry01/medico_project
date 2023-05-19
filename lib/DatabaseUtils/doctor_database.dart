import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad_project/DatabaseUtils/yourDoctor_database.dart';
import '../models/my_doctor.dart';
import '../models/my_medicine.dart';
import '../models/my_patient.dart';
import '../models/my_prescription.dart';
import '../models/my_prescription__exported_pdf.dart';

class DatabaseUtilsdoctor {
  static CollectionReference<DoctorDataBase> getDoctorsCollection() {
    return FirebaseFirestore.instance
        .collection(DoctorDataBase.COLLECTION_NAME)
        .withConverter<DoctorDataBase>(
          fromFirestore: (snapshot, options) =>
              DoctorDataBase.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }

  static CollectionReference<DoctorDataBase> getPatientsCollection() {
    return FirebaseFirestore.instance
        .collection(MyPatient.COLLECTION_NAME)
        .withConverter<DoctorDataBase>(
          fromFirestore: (snapshot, options) =>
              DoctorDataBase.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }

  static CollectionReference<Mymedicine> getMedicineCollection(
      String patientId) {
    return getPatientsCollection()
        .doc(patientId)
        .collection(Mymedicine.COLLECTION_NAME)
        .withConverter<Mymedicine>(
            fromFirestore: (snapshot, s) =>
                Mymedicine.fromjson(snapshot.data()!),
            toFirestore: (medicine, sp) => medicine.tojson());
  }

  static CollectionReference<Myprescription> getPrescriptionCollection(
      String patientId) {
    return getPatientsCollection()
        .doc(patientId)
        .collection(Myprescription.PRESCRIPTION)
        .withConverter<Myprescription>(
            fromFirestore: (snapshot, s) =>
                Myprescription.fromjson(snapshot.data()!),
            toFirestore: (prescription, sp) => prescription.tojson());
  }

  static CollectionReference<Myprescpdf> getMyPrescriptionPdfCollection(
      String patientId) {
    return getPatientsCollection()
        .doc(patientId)
        .collection(Myprescpdf.PRESC_PDF)
        .withConverter<Myprescpdf>(
            fromFirestore: (snapshot, s) =>
                Myprescpdf.fromjson(snapshot.data()!),
            toFirestore: (prescriptionPdf, sp) => prescriptionPdf.tojson());
  }

  static Stream<QuerySnapshot<Myprescpdf>> getMyPrescriptionPdfAsStream(
      String patientId) {
    return getMyPrescriptionPdfCollection(patientId).snapshots();
  }

  static Stream<QuerySnapshot<Myprescription>> getPrescriptionAsStream(
      String patientId) {
    return getPrescriptionCollection(patientId).snapshots();
  }

  static CollectionReference<MyPatient> getDoctorPatientsCollection() {
    return getDoctorsCollection()
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(DatabaseUtilsDoctorPatient.doctorPatientsCollection)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyPatient.fromjson(snapshot.data()!),
          toFirestore: (value, options) => value.tojson(),
        );
  }

  static Future<QuerySnapshot<Mymedicine>> getPatientMedicines(
      String patientId) {
    return getMedicineCollection(patientId).get();
  }

  static Stream<QuerySnapshot<MyPatient>>
      getDoctorPatientsCollectionAsStream() {
    return getDoctorPatientsCollection().snapshots();
  }

  static Future<void> AddUserToFirestore(DoctorDataBase doctorDataBase) {
    return getDoctorsCollection().doc(doctorDataBase.id).set(doctorDataBase);
  }

  static Future<DoctorDataBase?> readUserFromFiresore(String id) async {
    DocumentSnapshot<DoctorDataBase> user =
        await getDoctorsCollection().doc(id).get();
    var doctorDataBase = user.data();
    return doctorDataBase;
  }

  static Future<DocumentSnapshot<DoctorDataBase>> readUserDocumentFromFiresore(
      String id) async {
    DocumentSnapshot<DoctorDataBase> user =
        await getDoctorsCollection().doc(id).get();
    return user;
  }

  static Future<List<DoctorDataBase>> readDoctorFromFirestore() async {
    var snapshot = await getDoctorsCollection().get();
    return snapshot.docs.map((e) => e.data()).toList();
  }
}

class PatientData {
  final MyPatient myPatient;
  final List<Mymedicine> myMedicines;

  const PatientData({required this.myPatient, required this.myMedicines});
}
