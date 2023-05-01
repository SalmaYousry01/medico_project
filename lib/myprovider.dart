import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/models/my_patient.dart';


class MyProvider extends ChangeNotifier {
  MyPatient? patient;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }

  void initMyUser() async {
    patient = await DatabaseUtilspatient.readPateintFromFiresore(firebaseUser?.uid ?? "");
  }
}