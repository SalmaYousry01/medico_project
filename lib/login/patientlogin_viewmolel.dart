import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:grad_project/DatabaseUtils/Patient_Database.dart';
import 'package:grad_project/basenavigator.dart';
import 'package:grad_project/login/patientlogin_navigator.dart';
import '../models/my_patient.dart';
import '../shared/components/firebase_errors.dart';

class patientloginViewModel extends BaseViewModel<PatientLoginNavigator> {
  var auth = FirebaseAuth.instance;

  void PatientloginWithFirebaseAuth(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      MyPatient? patient = await DatabaseUtilspatient.readPateintFromFiresore(
          credential.user?.uid ?? "");
      if (patient != null) {
        //Go To Home
        navigator!.goToHome(patient);
        return;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.Wrongemail) {
        print('no match fount please enter the right email.');
      } else if (e.code == FirebaseError.Wrongemail) {
        print('password not correct.');
      }
    } catch (e) {
      print(e);
    }
  }
}
